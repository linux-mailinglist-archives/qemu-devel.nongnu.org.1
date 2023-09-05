Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96524792433
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:53:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYMo-0003jY-4Z; Tue, 05 Sep 2023 11:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qdYMl-0003gd-2V
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:53:23 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qdYMh-0008V7-7Z
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:53:21 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31ad9155414so2089074f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1693929197; x=1694533997; darn=nongnu.org; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PI1dObbVXrTjUXlDa/OecbfminrO4BVI+mXnu2qnXWM=;
 b=MZumB4WoxD9a3xsq3XYvH1OBzlbv/M7VyPAetT4+/SiWd2Y2Di9/5Xdj4aN0qlHu5K
 Yt3qTwh20q6fpucg67WTXVz5egH/MCu4AR0hVHNO0hIftHs/fS/y8/BRufVD8Rhq1FpV
 dwMCD//ZH92Ki7/SM8kUtwlkIEeG+uIT5wJ1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693929197; x=1694533997;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PI1dObbVXrTjUXlDa/OecbfminrO4BVI+mXnu2qnXWM=;
 b=BMTWKfUqm4hdZkXJeBxjO+gKjJr9q1gDTO4iEPeVdokLEwAQnLn4nLFTXhc47xZLVN
 tjn/DNwE8Que8wBXYWi2vTjojlWhbtuj6G5hp64LIk0u1n8HGjJY3vu5jePONXydJOzz
 CbKikwNnT7iM7+T05KVGP3QK+zwl2PC7QmPwmYmvagnW+1pVuBs+wccNzVEWSVOxs7jd
 ZhgqvvTl8gBTqZlw62jveNA4E1e6sLcWWX0PDTxADNDV8zGJmi3LuK3gyqCkgwlkhagV
 zbuShBcpAf+8jiQBDyb93cv4AzxheQawj1QFyQA0Vix6RE07Tmol2Q2nDK0AJG3eIBvG
 AV4g==
X-Gm-Message-State: AOJu0YyT8hebQ+JGanHllQwYEhLMNBY9abJiM1yQjj5EDG+HpdXHfkML
 8JixzhFiTXYtWYnMj8PnEebkwQ==
X-Google-Smtp-Source: AGHT+IHhzR3q+UBCT/nwiK9o31jfi7H0WEmLYOMXe83PPYm7G+cfSbBXTbXGGrEZB5VEigH6AwRwPA==
X-Received: by 2002:a5d:4441:0:b0:317:e04c:6791 with SMTP id
 x1-20020a5d4441000000b00317e04c6791mr166591wrr.62.1693929197218; 
 Tue, 05 Sep 2023 08:53:17 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9cbb:8ec6:1cb5:104e?
 ([2001:8b0:aba:5f3c:9cbb:8ec6:1cb5:104e])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a5d4e8d000000b0031c6cc74882sm17861962wru.107.2023.09.05.08.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 08:53:16 -0700 (PDT)
Message-ID: <58b3aa9437ac94d7665e7b93f4868f7e7d3f71b3.camel@linuxfoundation.org>
Subject: Re: mips system emulation failure with virtio
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Date: Tue, 05 Sep 2023 16:53:15 +0100
In-Reply-To: <d35f5c16-e75c-fc7f-57cb-c6f7a5e696fc@linaro.org>
References: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
 <87pm2whfyn.fsf@linaro.org>
 <0cbd86af5501f18007a926598c6e2232af240d00.camel@linuxfoundation.org>
 <d35f5c16-e75c-fc7f-57cb-c6f7a5e696fc@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.purdie@linuxfoundation.org;
 helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 2023-09-05 at 17:12 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Richard,
>=20
> On 5/9/23 16:50, Richard Purdie wrote:
> > On Tue, 2023-09-05 at 14:59 +0100, Alex Benn=C3=A9e wrote:
> > > Richard Purdie <richard.purdie@linuxfoundation.org> writes:
> > >=20
> > > > With qemu 8.1.0 we see boot hangs fox x86-64 targets.
> > > >=20
> > > > These are fixed by 0d58c660689f6da1e3feff8a997014003d928b3b (softmm=
u:
> > > > Use async_run_on_cpu in tcg_commit) but if I add that commit, mips =
and
> > > > mips64 break, hanging at boot unable to find a rootfs.
>=20
> Are you testing mipsel / mips64el?

No, it was mips/mips64, i.e. big endian.

Cheers,

Richard


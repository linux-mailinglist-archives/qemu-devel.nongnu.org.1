Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0CA7422F0
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:09:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEneK-00052I-FX; Thu, 29 Jun 2023 05:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEneJ-00051Q-2M; Thu, 29 Jun 2023 05:09:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEneH-00019M-Ja; Thu, 29 Jun 2023 05:09:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b80bce2592so2099115ad.2; 
 Thu, 29 Jun 2023 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688029747; x=1690621747;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4sawEr+Y/PYuMgdIFjfAnV9ofceTarQTqVcClUI7rk=;
 b=lu2ec+db+nWcgxwshMqemacVJgrO2sU9aOGwdMp8YduSQ+F3hMpVBZs7RY7rzkcP3g
 ErK1ARg5a7547Raug+SmJJb3Qy1z7OULEPc3DOPRxyMQiEhqyUHTXpeHcrIRDHiisTVE
 wl0zCN5628eZtNFPETKLmy1sFybXlaw0wo7gMneKScH2k1mD29RK536qVQsopDbmqy1k
 ag9fMI0KXXl21UoQ7ZFXJNRkDIWtY4uKEDcNNAmhtqwNamU2En4K79M/yW3NeEggoH1c
 qY05qIeNPAlwaaCH2JNHcYXygIGJ/u4aV8cT+oipITNInK5ilUl7gjCesfALLx6/eIz3
 BoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688029747; x=1690621747;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E4sawEr+Y/PYuMgdIFjfAnV9ofceTarQTqVcClUI7rk=;
 b=kjneEwk8cUAOjoDMnQfFwfXRZAoWsIAfexXs2ZQLSI/cw+bvad7uQzgOdl/rTf0adu
 kO1Rp+RYJ74ExQkCzAdVGWOelog/A5BlSrnmfmxkYE8G00jvpbYc9i4UWWk+hwJ1t+Nd
 KOBEB5GorDWtU1NLmRYN3mLn+yzKvH5L+lp3t7salWG1ikgAT3B/+hglp5e4Aa+ccPzs
 ZZav7JmGw+1k6bEpWSGyyzxcMrUy2hrw5bxCwchkUh/K82/zPXnlmge+LzwWBhUatWpG
 Qthv0qqPZ9sWNwT+wDDoCHCbL9o6xXmmFsrxKrPwksHQiXNEu8caPmaKhN5FMjK5CVN2
 bkIQ==
X-Gm-Message-State: AC+VfDwqtoptd8jO3tiIZ4HcXWUGsX4luC5Qp9wsjBXzGmULbJoLmZJv
 r4OpxvBO8YwOjEzdsRJYcH8=
X-Google-Smtp-Source: ACHHUZ5i0wIf7zSAMELnUDMJXVcjUhheWDq9Tpzzio5TkHREP6AN8Jnmeh+VgENlx/Y7r5hEP0mvJA==
X-Received: by 2002:a17:902:ccc3:b0:1b1:9d3c:66c9 with SMTP id
 z3-20020a170902ccc300b001b19d3c66c9mr12400329ple.5.1688029747269; 
 Thu, 29 Jun 2023 02:09:07 -0700 (PDT)
Received: from localhost (203-219-179-91.tpgi.com.au. [203.219.179.91])
 by smtp.gmail.com with ESMTPSA id
 jl3-20020a170903134300b001ac6b926621sm8756302plb.292.2023.06.29.02.09.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 02:09:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Jun 2023 19:09:01 +1000
Message-Id: <CTP0LPUSWK96.21C2Z4SQ7AZ05@wheely>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] target/ppc: Implement attn instruction on BookS
 64-bit processors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230627134644.260663-1-npiggin@gmail.com>
 <20230627134644.260663-5-npiggin@gmail.com>
 <32a75db0-381d-9a55-05ec-047bf40f3300@linaro.org>
In-Reply-To: <32a75db0-381d-9a55-05ec-047bf40f3300@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed Jun 28, 2023 at 7:38 PM AEST, Richard Henderson wrote:
> On 6/27/23 15:46, Nicholas Piggin wrote:
> > +DEF_HELPER_1(attn, void, env)
>
> s/void/noreturn/

Thank you x2, agree.

Thanks,
Nick


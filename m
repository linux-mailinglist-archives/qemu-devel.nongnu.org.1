Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4A376D183
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:15:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRDYz-0004Sv-CM; Wed, 02 Aug 2023 11:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRDYv-0004K8-Ol
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:14:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRDYu-0002ek-5X
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:14:57 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68706d67ed9so4442845b3a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690989295; x=1691594095;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yku5/UH3J78smNTKsX1sCZg3Glu9jchN05Op9s5aYbI=;
 b=xd6uWrweb/2kTcE6zc2T4XJU2PZF22TMVHe2NKzi+Y13z8W3offf75+xw4vFBmSznc
 QSEuHepWrEwL0WlUreKb+WitF9OWtrVA+bG53dW+WGU1NKS8BUYloBb+/1RY1ohR9n4n
 bwqC7sIGSh+SjEF5B4Of0D9DtiT6/uvuSnEwrAJ6cmcC793j8jKfznvzNCMg9L7Morlh
 WBPNjYf7Jy7+FEoMNwEfMlxwh8/cmX4pALaF4jpQJ8eu5JfvgLIFqd3U7ij8V/RFHE7a
 sBjVsiMN9FPSDsjs/zjF9JLSh5lrGSPuAfibCh3VdxOUUC9TrIpPi+l8xPwwk7/5PiZJ
 4dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690989295; x=1691594095;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yku5/UH3J78smNTKsX1sCZg3Glu9jchN05Op9s5aYbI=;
 b=cCVz5bIcu2EU7gv6Kx/gmMdcVxL1MWCt8oDmZhXkUo5EYV0+0JXKPl2153qEN7CcxE
 NGLaKGpcmzq60L0M3lcWf8iKtFfvGGkNXTYTTuJPWIXHnRM7VxqAM98TzzLlj0QaiR5D
 oi0SppP75chSz8taQDEvB+286APhQX3xysdyaGIxKFCgBUiZVjHwsaqF5U2ZDliPCwWg
 f8RLIid7163BS8SAvwNfQMWMmhsdDkyr9Fu/rtMVAeodxPmRnTxpftwxO4N5upaRSRPG
 Kccmii6g2+bVs10KjaRQww5c8dnEXK8hxc/5Xos2vuuHoGL2hZpEioxwHmQGYURf1ErZ
 mtlQ==
X-Gm-Message-State: ABy/qLZGMG6Q470p71ONR608VtzhPLC7s3m6uswnw6IDG9i5C7pzd05z
 Hvg68k6kKgKiRG3zoZ9iYeyf7zDZP7lY7OLhLWY=
X-Google-Smtp-Source: APBJJlGGlM0kVPpfhRDCAttLT2IQ7gncwyjxBXpkP/5Ir3u1lDoB6as3oWJiTvNSimIgYleVvuXaAA==
X-Received: by 2002:a05:6a00:1ad3:b0:687:1184:5420 with SMTP id
 f19-20020a056a001ad300b0068711845420mr17604632pfv.0.1690989295057; 
 Wed, 02 Aug 2023 08:14:55 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 k12-20020aa790cc000000b00682c1db7551sm9048593pfk.49.2023.08.02.08.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 08:14:54 -0700 (PDT)
Message-ID: <04862d4b-d998-e557-d740-3ae863eb97c3@linaro.org>
Date: Wed, 2 Aug 2023 08:14:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/3] QAPI patches patches for 2023-08-02
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20230802074041.418954-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230802074041.418954-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 8/2/23 00:40, Markus Armbruster wrote:
> The following changes since commit 38a6de80b917b2a822cff0e38d83563ab401c890:
> 
>    Merge tag 'pull-xen-20230801' ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm  into staging (2023-08-01 07:27:31 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git  tags/pull-qapi-2023-08-02
> 
> for you to fetch changes up to 2b3edd95186dc505f21d823119cdd0dfb23b3ee0:
> 
>    MAINTAINERS: Add section "Migration dirty limit and dirty page rate" (2023-08-02 09:33:38 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2023-08-02
> 
> ----------------------------------------------------------------
> The patches affect only documentation.  Generated code does not change.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



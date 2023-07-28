Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD6B767729
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 22:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPTiJ-0004ke-Io; Fri, 28 Jul 2023 16:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qPTiF-0004k9-JX; Fri, 28 Jul 2023 16:05:24 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qPTiD-000223-EP; Fri, 28 Jul 2023 16:05:23 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a426e70575so1714033b6e.0; 
 Fri, 28 Jul 2023 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690574718; x=1691179518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mftFljctRhrDVVyQEMmduKtaxVXv87+5PoEDqi2A84I=;
 b=SU9aKF9DvfhfqONl7DDJ1JKnD8torUW4e8ZhOnQvArfXAO1yT+lW0FxHJPJMpuxCrD
 CT5VPrzaGisu3X4rFYBMOINZJV8lx3mOWQgo7yJQRjaXuijZtCIwk7E1Tb7tG4fu75lz
 aFLUtSZLTTGSKfIiqqEEyEXxh1fm763SbEydJueX8DAp51bUtEeq5j61gOWY6QEZSMgY
 pwO7qorozfoupetmqA480zntnlwst8GWfQ1bSHweICuvvEufYmV4QZoBWOjdvbNuHzoD
 O5Ya0SRBUZiNdV0SYPFP853E7DGJCvWgSOyirTxtq3PvKr0pWzJE2zf7czTEmQ7TXSk9
 Vauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690574718; x=1691179518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mftFljctRhrDVVyQEMmduKtaxVXv87+5PoEDqi2A84I=;
 b=GzlDC/vI4jLqz59xw0Xff5OvkgALN2lZyu1p6UgOMMMctFTb7p8jX87btOUolAuO+i
 FenWIWTUZroraBtmc3iKoZ1ANrWkrsKSYc2+fY30Jet3G8QcopClrgG/h63BPuctxIvD
 JUPoUTHqehqxUvC8oYSUdywF6KqPu/sWqH5E+uKOqRRqqrH1EBWD/NxTlqheYiG51Jc1
 sw9ikJ8XKQOF25Jbt0L8rwYZs/iuPwO0q+LAFG5q6scqtdkAx/L8l4uNKu4D24AMbz/N
 aaTAfL+2vPShySUizNlLnVfbLVVjNQ89c8e4jcmF2Ub0NPVq/QoEG+Q+Gv6/LHCgjruv
 Z0kA==
X-Gm-Message-State: ABy/qLZ75kk2P1rVsBe2DOZjXxGCc02fZK9buhIiEExVl1r7u06mLbqV
 i2jN3+6omfMlniarCrHDpTn2lum5GLI=
X-Google-Smtp-Source: APBJJlE1CYI9pf6Tu/u6QLLofagVKNJnpR/M2caOXjVCvJwpH+HboEOVm8UGpDVuMfpvHCr0tBNIoQ==
X-Received: by 2002:a05:6808:16ac:b0:3a2:ee94:5548 with SMTP id
 bb44-20020a05680816ac00b003a2ee945548mr4146480oib.52.1690574718617; 
 Fri, 28 Jul 2023 13:05:18 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-36.dial-up.telesp.net.br.
 [201.69.66.36]) by smtp.gmail.com with ESMTPSA id
 i12-20020aca2b0c000000b003a1f359ba4esm1990172oik.14.2023.07.28.13.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 13:05:18 -0700 (PDT)
Message-ID: <2068f4e1-8d73-26af-3df9-93b5d803db13@gmail.com>
Date: Fri, 28 Jul 2023 17:05:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] ppc fixes possibly for 8.1
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726182230.433945-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230726182230.433945-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.094,
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



On 7/26/23 15:22, Nicholas Piggin wrote:
> Sorry for the delay following up on the fixes, I got sucked down
> the decrementer rabbit hole that took longer than expected.
> 
> Question about what is suitable for merge at this time and what
> should be stable. The first 3 have caused crashes or hangs running
> Linux and other software. Second 3 fix some issues with dec that
> could cause problems, especially with migration. But they affect
> more machines in more complex ways than the first 3.
> 
> No changes to the first 3 already posted except to add Fixes:
> tags.

Patches 1 and 3 queued in ppc-next. Thanks,


Daniel

> 
> Thanks,
> Nick
> 
> Nicholas Piggin (6):
>    target/ppc: Implement ASDR register for ISA v3.0 for HPT
>    target/ppc: Fix VRMA page size for ISA v3.0
>    target/ppc: Fix pending HDEC when entering PM state
>    hw/ppc: Avoid decrementer rounding errors
>    hw/ppc: Always store the decrementer value
>    target/ppc: Migrate DECR SPR
> 
>   hw/ppc/ppc.c             | 47 +++++++++++++++------------
>   target/ppc/excp_helper.c |  6 ++++
>   target/ppc/machine.c     | 14 +++++++++
>   target/ppc/mmu-hash64.c  | 68 ++++++++++++++++++++++++++++++----------
>   4 files changed, 98 insertions(+), 37 deletions(-)
> 


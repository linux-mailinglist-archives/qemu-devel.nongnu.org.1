Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 019D3759891
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:39:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM8Kh-0004qO-D0; Wed, 19 Jul 2023 10:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8Kf-0004q7-I8
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8Ke-0000Fv-7E
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689777551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzreXpAAaoJvSZvH6vnyzlvxfCHVqD9NURICMmcf/ZQ=;
 b=AXok1Gfp6D6Jd+dPX1mzYramdL/PzhPEczzD4M51+kQKcQ1IAl5ILGLNEHav4iOaDBs+nO
 itSKn89ntcUNuCHUbJOublVGgvZxo/OBlxqkt74qJi55aYRhyR/mHe+cIum59hiZJnFVVX
 hjdqu/R+mdP9IEygrOFRxJAW+YrDnSY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-5_F8iwpaPPmfe2ZTGgAlwA-1; Wed, 19 Jul 2023 10:39:10 -0400
X-MC-Unique: 5_F8iwpaPPmfe2ZTGgAlwA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fdbd94e735so3477378e87.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689777548; x=1692369548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uzreXpAAaoJvSZvH6vnyzlvxfCHVqD9NURICMmcf/ZQ=;
 b=CMx3JEkEp0UaiLSH/s68rWXMpKQoIb3hZd/ciTh6ouQVw1m6dUJyBJb0bTfWRUHE0F
 nRIjlJ+feVYgVAZG5hOai9+rezQE9gIn9Vnr01FSeCBpmKQOBpoc+eGnTDy9MdcFAkzJ
 sTtONTzOj4CmYnF9AN+byNR4kon5r6hQN0KI+33TpbwRBsSSyZ8HpXAg0Jx4f1Hthfyw
 PwkKE0Kjx08LlE3jeqKCb1sLUP68Rsg6wvpG0Bz/FhBoBloaw1TKnaRnvDGQyMmwKgtu
 CpmKH+7lU0jGbKbuPOnxdxZaDgptiVsEEPzzvqtMuXdC8wZ1m5QBk7L/SLYN29K6vb2Q
 NY3w==
X-Gm-Message-State: ABy/qLbHTfcniUp0Jhkj86fgH6XNYc0n9RrHPuEOPOi67AwRLMJLgHpr
 q8HugdqmO34mOnMukZY0SgiD63H0KA4yK+HQn9bOBf9marAnbjNBmzP57ejjPRsl56QKk8naBYI
 fC+21ySnNk3KJ8EDl+Hdwc5w=
X-Received: by 2002:a19:3843:0:b0:4f1:4cdc:ec03 with SMTP id
 d3-20020a193843000000b004f14cdcec03mr71934lfj.18.1689777548667; 
 Wed, 19 Jul 2023 07:39:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFLbdIzrqqNc1z9SvTWRG2GKW40XelvtzlIpNEhOjNt86pDm4j2qyYEql6iMrD98OW/oUwu4A==
X-Received: by 2002:a19:3843:0:b0:4f1:4cdc:ec03 with SMTP id
 d3-20020a193843000000b004f14cdcec03mr71922lfj.18.1689777548401; 
 Wed, 19 Jul 2023 07:39:08 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 q13-20020a1ce90d000000b003fa95890484sm1892078wmc.20.2023.07.19.07.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:39:07 -0700 (PDT)
Message-ID: <9e1373af-cf25-ca59-fe1e-938f415d96b1@redhat.com>
Date: Wed, 19 Jul 2023 16:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 12/14] tests/tcg/s390x: Test MC
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-13-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230719094620.363206-13-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 19/07/2023 11.44, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.softmmu-target |  1 +
>   tests/tcg/s390x/mc.S                    | 56 +++++++++++++++++++++++++
>   2 files changed, 57 insertions(+)
>   create mode 100644 tests/tcg/s390x/mc.S

Tested-by: Thomas Huth <thuth@redhat.com>




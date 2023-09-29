Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A267B2997
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 02:32:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm1Qq-0005vV-S0; Thu, 28 Sep 2023 20:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qm1Qo-0005tF-Ss
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:32:34 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qm1Qn-00047A-B5
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:32:34 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7ab5150a7b5so95672241.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 17:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1695947552; x=1696552352;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6fSTqFysmqN+uanF2/uSPtL6xLjjfAQpmCRViTqM9X8=;
 b=ukXDM96afwHoD+9HQvO8nulXX2JTYjQ5TCvaV5q9ZGeVv9ceyhlVp7MqnCHKZz1ihv
 vYKbv0HljcNc4WBkGuYWvRuJ+5lr+gGW3AMkChOX5GU9pk8dYttTdPS8hzJXX15fMxYS
 McwXBgOJjtXYPyJyinzFXU4xY8PITYr0GMvZ4rqB0berUmbDkgBHSNIH6O9MEHzmFiYX
 8DkqS1n6+keG3mHCqmAcxMLeH9JcOvyUK8XfhHjRAIlMNTqClos6KmHq57wkgbW60kNg
 uvqXlhL9aUe4DbQy3aygD+IOQCtdvN52RsDc7LOTV8SyMWDzPwzWqL8pnsO04XK79CZp
 6JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695947552; x=1696552352;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6fSTqFysmqN+uanF2/uSPtL6xLjjfAQpmCRViTqM9X8=;
 b=GBEEAQaADg9mTyI3nXZFpYrdQMuPtCEYq2M04O7JTQalav4KrMFXGU57PlclJqcTbV
 9h5WTi5ni1IVqIj57xidxTQWZ/RIvf/Az/mEwUWBYHVLLiiUc1Su6gZJBeLLZHsYnyG9
 l+gv3WU5X5JAU5ihZuxX34Ruzu9Rrf2pJIdKqsINUgZsa3GHO1E2MAQVNuGnwVQAU/gI
 CTOoYkEdP5L6RuPu21WtGhnIRaCDqlbG5Bv2DwRL8ZPrH0XL4Mjjc7fxiQEA7hYZZupa
 z8y3JUVryyMmpiFPBNH482ONCXk8sEFNm9D1kyqsWdjOzXsExcw8HlKV6hfc84oob61U
 99Wg==
X-Gm-Message-State: AOJu0YwqudgDfHz1FW8gtBxnNyJDLJLmGIn/oh8q6MTmNvBSdmh7O+W0
 +Knn3LE9o+gXjXTutKgBt+ooQPLh61S3JGHK6kS0+9HI9FJCc8ug
X-Google-Smtp-Source: AGHT+IFSwbZL6rru5TTdEk/gTQLZ4WYhbcsi9q/GP1f5tH6aj7WsMbzxFr1kberit6b7HvoT3fZfBsHDJfnE49dYtlI=
X-Received: by 2002:a05:6102:ed5:b0:450:985f:ef28 with SMTP id
 m21-20020a0561020ed500b00450985fef28mr1639894vst.5.1695947551865; Thu, 28 Sep
 2023 17:32:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2a92:0:b0:7aa:d493:bd29 with HTTP; Thu, 28 Sep 2023
 17:32:31 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <de8992b1-9f7c-b6ae-aaf3-af267674f71b@linaro.org>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-7-nbowler@draconx.ca>
 <de8992b1-9f7c-b6ae-aaf3-af267674f71b@linaro.org>
From: Nick Bowler <nbowler@draconx.ca>
Date: Thu, 28 Sep 2023 20:32:31 -0400
Message-ID: <CADyTPEw_ByU9X4vP6UBr+O-_77k1h7VMvSP7+mrgqBtMtV0AMA@mail.gmail.com>
Subject: Re: [PATCH 6/8] target/sparc: Fix VIS fpmerge input registers.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2607:f8b0:4864:20::92d;
 envelope-from=nbowler@draconx.ca; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023-09-28, Richard Henderson <richard.henderson@linaro.org> wrote:
> On 9/24/23 01:03, Nick Bowler wrote:
>>                   case 0x04b: /* VIS I fpmerge */
>>                       CHECK_FPU_FEATURE(dc, VIS1);
>> -                    gen_ne_fop_DDD(dc, rd, rs1, rs2,
>> gen_helper_fpmerge);
>> +                    cpu_src1_32 = gen_load_fpr_F(dc, rs1);
>> +                    cpu_src2_32 = gen_load_fpr_F(dc, rs2);
>> +                    cpu_dst_64 = gen_dest_fpr_D(dc, rd);
>> +                    gen_helper_fpmerge(cpu_dst_64, cpu_src1_32,
>> cpu_src2_32);
>> +                    gen_store_fpr_D(dc, rd, cpu_dst_64);
>>                       break;
>
> Use gen_ne_fop_DFF.

Good catch, I clearly missed that this can use the new helper, I will
respin this one.

Thanks,
  Nick


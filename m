Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C017D8DDE
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 06:45:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwEhp-0008K5-Ui; Fri, 27 Oct 2023 00:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qwEhn-0008Jf-FD
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 00:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qwEhl-0001Ci-KW
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 00:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698381856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/0ThB1f4EUHggG9SdzzN6yXqBONHcM8sgtv/weMHLY=;
 b=Xe/7uggWpNMAZFWGwOZJYPkD9+D3p8BTYhbUMYhiG2tYzq4STF34WuLS4AGrQex7z4GnJO
 Egu1t9WGCgXll8RiT0UzGnzc0LhVozSIRiy53pwXX39De4AIhdL2CgoKg0dTYHrY8JiAKP
 NkvFtQF24SUFsI23ceXUVuq1pl0ycss=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Pjn0RlheOxy_BiMUSjU4Pg-1; Fri, 27 Oct 2023 00:44:12 -0400
X-MC-Unique: Pjn0RlheOxy_BiMUSjU4Pg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d35dda745so20698046d6.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 21:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698381852; x=1698986652;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e/0ThB1f4EUHggG9SdzzN6yXqBONHcM8sgtv/weMHLY=;
 b=D7iseq47Y6s1DbeSjOzKyP+H3Nf5ehoppjgmYa+DTgP5VaZvLP5JESfdmFAk+0Umdo
 z9q4Q9HyHox+htcfeaS7PzYdbjP1zV2aHtDbq1ICxR53rZRd+1O0c3RxKe1BEHKRf889
 LNOFcu8xTj7qXxY9+2QcxCjaTdyc1ta4zoN8+FUrFi/cOWDesuRuNt9P3EXurI+cC2u/
 hdSWCF1ORDN8vD2439JFKwe3/UGIIBcdFrrMtgefSkhdNUSIwgd/Rz8dSOQ6gREuh+Fu
 v0GAxP7n/uFAtR9XehZEQxlTC6f2arWTEJRQ2vLNDUBQ1VvHkGxrCViqLCMMy7G62jrl
 N10A==
X-Gm-Message-State: AOJu0Yxor8j7dwjd7yS55suAO1HPFhxv7SWu2nRgioJDMnwtKdz7m+ZE
 l7KhIFjaLV+p7FbJvVLC7fADLZmpM9NtXS48NTWE08CH9uOH+lK8ucnONqkDEaaN3vjjhfbKRw5
 6NLK8WyMQN3aH9ZM=
X-Received: by 2002:ad4:5ca1:0:b0:66d:6af7:4571 with SMTP id
 q1-20020ad45ca1000000b0066d6af74571mr2074988qvh.17.1698381851835; 
 Thu, 26 Oct 2023 21:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdXI3JWnP8HU7Mfcr20qPsHA80B1IlJb45PE6LAyDNyQgC8kvyi9C1Nh04eb6xExpOljLHFQ==
X-Received: by 2002:ad4:5ca1:0:b0:66d:6af7:4571 with SMTP id
 q1-20020ad45ca1000000b0066d6af74571mr2074977qvh.17.1698381851497; 
 Thu, 26 Oct 2023 21:44:11 -0700 (PDT)
Received: from [172.19.1.246] ([192.80.84.35])
 by smtp.googlemail.com with ESMTPSA id
 h25-20020a0cab19000000b0065b31dfdf70sm336558qvb.11.2023.10.26.21.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 21:44:11 -0700 (PDT)
Message-ID: <dce5be86-19c7-49e1-90af-acf2c94d05b8@redhat.com>
Date: Fri, 27 Oct 2023 06:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/29] tcg/aarch64: Generate TBZ, TBNZ
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
 <20231026001542.1141412-17-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231026001542.1141412-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/26/23 02:13, Richard Henderson wrote:
> +    case TCG_COND_TSTEQ:
> +    case TCG_COND_TSTNE:
> +        if (b_const && is_power_of_2(b)) {
> +            tbit = ctz64(b);
> +            need_cmp = false;
> +        }

I think another value that can be handled efficiently is 0xffffffff 
which becomes a "cbz/cbnz wNN, LABEL" instruction.

This could be interesting if the i386 frontend implemented JE/JNE and 
JS/JNS (of sizes smaller than MO_TL) using masks like 0xffffffff and 
0x80000000 respectively.  Like (for SF):

      MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
      if (size == MO_TL) {
          return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst,
                               .mask = -1 };
      } else {
          return (CCPrepare) { .cond = TCG_COND_TSTEQ, .reg = cpu_cc_dst,
                               .imm = (1ull << (8 << size)) - 1,
                               .mask = -1 };
     }

Then on aarch64, JE could become CBZ and JS could become TBNZ.

Unfortunately, the code produced on x86 is not awful but also not too 
good; we discussed earlier how TST against 0xffffffff and 0x80000000 can 
be computed efficiently using "testl reg, reg", but you don't get to 
that point in tcg_out_testi because the other conditions require an S32 
constraint.  Those constants don't satisfy it. :(  So you lose the sign 
extension instructions, but you get a somewhat bulky MOV to load the 
constant followed by "testl reg, reg_containing_imm".

I guess in principle you could add 
TCG_TARGET_{br,mov,set}condi_valid(cond, const) but it's pretty ugly.

Paolo



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 764FC70DDF5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:51:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SQB-0002kr-4Q; Tue, 23 May 2023 09:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1SPu-0002Qf-4s
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1SPs-0002DM-Mz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684849866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2X02jT7y+8OLrfdFCK/L8Zp+Fxh6PaHD/EYM66pcoKs=;
 b=h8WnvHbgL960pKycWvWi3cglty1SuzSI70RP9BAJx7iTLKpqxc8L3g3LweE8BQLC57LXQK
 GfILS7EjdmvVJljq7Hqzvf9Jnz16mzVlkR+D9shSsEgDx7CxkW0UNObFQM1kUmQX+hDa2u
 ykTq7MbhccCTXlA2wEbeYssL8YXpD/A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-GBTxWkklOmqLB7kDLFseqQ-1; Tue, 23 May 2023 09:51:04 -0400
X-MC-Unique: GBTxWkklOmqLB7kDLFseqQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30940b01998so2727287f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849863; x=1687441863;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2X02jT7y+8OLrfdFCK/L8Zp+Fxh6PaHD/EYM66pcoKs=;
 b=X8nVERZ77GMxOvUPYwjnMsCegihg+wEirNRzseALXxdc6DcfF+2TGMePc9bik5+21Q
 XIJ9HoC/l9T2xUevvcXANVixuIDGwVK3KGYKOZJgH8PGzx0d/D6cmukvr3el2VIR0q2l
 UW2v//qh1cbdtUp2XlCizuoLenrqgvj4Cudd7Z9mM+FxbPT/+jG9JaGKFecJKvfnh0lb
 OOb0s8dzRMVdg6SAv1kLxMY4E4E5tUb0L5PYgsfFv9xXCmMV+EANIgHsXDCv9xZPXYjb
 tosuJl6JPSFY1YZm97uB7/9WSbBTFv7MTBDQgVv+DXyLxOiHg2ONu7xqqtacJKvZriQV
 Zs5w==
X-Gm-Message-State: AC+VfDxqrzINgg59sDKKgl/0YzjiYfH6Y2WoqKd16nvyMPDIqNrvfZQG
 NdWtbg5uhHCpDp1j8QOA6Yf+QJIuV+oAWRyzrAyA8s8uPPnmFdTzxa41i/772YK5EH+7ImEC/zz
 VE8NIAK38yhYThMs=
X-Received: by 2002:adf:ee0e:0:b0:309:452c:2189 with SMTP id
 y14-20020adfee0e000000b00309452c2189mr11043821wrn.57.1684849863533; 
 Tue, 23 May 2023 06:51:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74AFy9yQVZudsuKeP0kPLBkZsYteHLhJcDCQalgHnq2l4ekD0Hf/+HfEZLoVRv2JMcAZUw0g==
X-Received: by 2002:adf:ee0e:0:b0:309:452c:2189 with SMTP id
 y14-20020adfee0e000000b00309452c2189mr11043800wrn.57.1684849863184; 
 Tue, 23 May 2023 06:51:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd?
 (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de.
 [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d4dc5000000b002fe13ec49fasm11112830wru.98.2023.05.23.06.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 06:51:02 -0700 (PDT)
Message-ID: <b91fe1b1-0bfd-cf1f-14dc-457a765c3dce@redhat.com>
Date: Tue, 23 May 2023 15:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 17/27] target/s390x: Use cpu_{ld,st}*_mmu in do_csst
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-18-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230523134733.678646-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23.05.23 15:47, Richard Henderson wrote:
> Use cpu_ld16_mmu and cpu_st16_mmu to eliminate the special case,
> and change all of the *_data_ra functions to match.
> 
> Note that we check the alignment of both compare and store
> pointers at the top of the function, so MO_ALIGN* may be
> safely removed from the individual memory operations.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: qemu-s390x@nongnu.org
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb



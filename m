Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 935A8756172
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 13:21:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLMGx-00010j-Qo; Mon, 17 Jul 2023 07:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qLMGv-00010L-IO; Mon, 17 Jul 2023 07:20:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qLMGs-0003WM-Hr; Mon, 17 Jul 2023 07:20:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F1251144CE;
 Mon, 17 Jul 2023 14:20:01 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 67EF81528E;
 Mon, 17 Jul 2023 14:20:00 +0300 (MSK)
Message-ID: <f9a5d509-f6bb-8738-b83b-7808887abcea@tls.msk.ru>
Date: Mon, 17 Jul 2023 14:19:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 4/9] target/i386: Adjust feature level according to
 FEAT_7_1_EDX
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>, qemu-stable@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20230707140432.88073-1-pbonzini@redhat.com>
 <20230707140432.88073-5-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230707140432.88073-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.097,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

07.07.2023 17:04, Paolo Bonzini wrote:
> From: Tao Su <tao1.su@linux.intel.com>
> 
> If FEAT_7_1_EAX is 0 and FEAT_7_1_EDX is non-zero, as is the case
> with a Granite Rapids host and
> '-cpu host,-avx-vnni,-avx512-bf16,-fzrm,-fsrs,-fsrc,-amx-fp16', we can't
> get CPUID_7_1 leaf even though CPUID_7_1_EDX has non-zero value.
> 
> Update cpuid_level_func7 according to CPUID_7_1_EDX, otherwise
> guest may report wrong maximum number sub-leaves in leaf 07H.
> 
> Fixes: eaaa197d5b11 ("target/i386: Add support for AVX-VNNI-INT8 in CPUID enumeration")
> Cc: qemu-stable@nongnu.org

This patch is not applicable for any stable qemu releases, since the
commit it fixes (eaaa197d5b11, which also introduced FEAT_7_1_EDX) is
not in any released version, it is v8.0.0-290-geaaa197d5b.

This is just for the information (I'm not picking it up for stable),
there's nothing wrong with it tagged for stable initially.

Thanks!

/mjt


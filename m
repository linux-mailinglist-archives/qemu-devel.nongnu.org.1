Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D479A2EA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 07:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfZcn-0004XB-Ed; Mon, 11 Sep 2023 01:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qfZck-0004Wz-Cd
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 01:38:14 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qfZcg-0001eM-KV
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 01:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694410690; x=1725946690;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=H8/gYA8HMThoxPk4LkJilXO7ezSGie4x1CAixa//7zg=;
 b=mNpKIQ44Q4eKVZmwTx2Ik/mEmt5kyvKR0NnnN0JIRzUMV63mQJaHKVRv
 BcGnYiN1sbfP7g0mXpKoNQB+F999/dZzh+5vi8w4TKVKgZIbqi5B/wFEg
 9eujFTuSytt/P30iOMFys2CAziSRvKL2tKYJLa04nCRpJAZ8L22OTzZi+
 UwpvI7Jodpw3vbur1YomhkTwg46usIoUqGKFBXQ5hAgI1DK+NN4uEs5RI
 d185Og/LKKbtoH9FdwCDP750jgExnQI0QwwY0EupycRUGQeQFsDGOiiwb
 M/+WmYb3YH+4XV5/Nm0meNqMdvah27RZrmIMQIebFNQViu41GiJZ22KIL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="376913321"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
 d="scan'208,217";a="376913321"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2023 22:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="866794503"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
 d="scan'208,217";a="866794503"
Received: from qianwen-mobl1.ccr.corp.intel.com (HELO [10.238.5.29])
 ([10.238.5.29])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2023 22:38:04 -0700
Content-Type: multipart/alternative;
 boundary="------------wXVEnyDLW2Oxs0ZADzVA3xcJ"
Message-ID: <a8e3163c-0161-69df-e00c-fb12b296ecc8@intel.com>
Date: Mon, 11 Sep 2023 13:38:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 0/2] Fix overflow of the max number of IDs for logic
 processor and core
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, zhao1.liu@intel.com, richard.henderson@linaro.org,
 babu.moger@amd.com
References: <20230829042405.932523-1-qian.wen@intel.com>
Content-Language: en-US
From: "Wen, Qian" <qian.wen@intel.com>
In-Reply-To: <20230829042405.932523-1-qian.wen@intel.com>
Received-SPF: pass client-ip=192.55.52.120; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_MED=-2.3,
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

This is a multi-part message in MIME format.
--------------wXVEnyDLW2Oxs0ZADzVA3xcJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kindly ping for any comments.

Thanks,
Qian

On 8/29/2023 12:24 PM, Qian Wen wrote:
> CPUID.1.EBX[23:16]: Maximum number of addressable IDs for logical
> processors in this physical package.
> CPUID.4:EAX[31:26]: Maximum number of addressable IDs for processor cores
> in the physical package.
>
> The current qemu code doesn't limit the value written to these two fields.
> If the guest has a huge number of cores, APs (application processor) will
> fail to bring up and the wrong info will be reported.
> According to HW behavior, setting max value written to CPUID.1.EBX[23:16]
> to 255, and CPUID.4:EAX[31:26] to 63.
>
> ---
> Changes v3 -> v4:
>   - Add "Reviewed-by" from Isaku and Xiaoyao.
>   - Rebase to the v8.1.0.
> Changes v2 -> v3:
>   - Add patch 2.
>   - Revise the commit message and comment to be clearer.
>   - Using MIN() for limitation.
> Changes v1 -> v2:
>   - Revise the commit message and comment to more clearer.
>   - Rebased to v8.1.0-rc2.
>
> Qian Wen (2):
>   target/i386: Avoid cpu number overflow in legacy topology
>   target/i386: Avoid overflow of the cache parameter enumerated by leaf
>     4
>
>  target/i386/cpu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> base-commit:f5fe7c17ac4e309e47e78f0f9761aebc8d2f2c81
--------------wXVEnyDLW2Oxs0ZADzVA3xcJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p><font face="Calibri">Kindly ping for any comments.<br>
        <br>
      </font>Thanks,<br>
      Qian<br>
    </p>
    <div class="moz-cite-prefix">On 8/29/2023 12:24 PM, Qian Wen wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20230829042405.932523-1-qian.wen@intel.com">
      <pre class="moz-quote-pre" wrap="">CPUID.1.EBX[23:16]: Maximum number of addressable IDs for logical
processors in this physical package.
CPUID.4:EAX[31:26]: Maximum number of addressable IDs for processor cores
in the physical package.

The current qemu code doesn't limit the value written to these two fields.
If the guest has a huge number of cores, APs (application processor) will
fail to bring up and the wrong info will be reported.
According to HW behavior, setting max value written to CPUID.1.EBX[23:16]
to 255, and CPUID.4:EAX[31:26] to 63.

---
Changes v3 -&gt; v4:
  - Add "Reviewed-by" from Isaku and Xiaoyao.
  - Rebase to the v8.1.0.
Changes v2 -&gt; v3:
  - Add patch 2.
  - Revise the commit message and comment to be clearer.
  - Using MIN() for limitation.
Changes v1 -&gt; v2:
  - Revise the commit message and comment to more clearer.
  - Rebased to v8.1.0-rc2.

Qian Wen (2):
  target/i386: Avoid cpu number overflow in legacy topology
  target/i386: Avoid overflow of the cache parameter enumerated by leaf
    4

 target/i386/cpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

base-commit:f5fe7c17ac4e309e47e78f0f9761aebc8d2f2c81
</pre>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------wXVEnyDLW2Oxs0ZADzVA3xcJ--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E257A774E88
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 00:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTVSQ-0002e0-A9; Tue, 08 Aug 2023 18:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTVSN-0002dm-U8
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 18:45:40 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTVSK-0006Bm-U6
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 18:45:39 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686fc0d3c92so4264260b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691534735; x=1692139535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4zoE2ZwVmHBor7Y96sjSCtAhah8L8hrknysTAlUT2V4=;
 b=TAbwMfuSrFyqTDzYJUvyeiyrMdaH+DlnAaTUV1QkPbXywrrqe/pvbJjxws3pPHJOTg
 W8uV7bpAUM54z2Cqlimx+XxNtLZKpKTqLmqbCIGVmFGz+xGtay+sfU0BTCR0jlIhqwtC
 uOxb2F56Wl3oOJMk03RFyAOng8AxQHx4wKADo4Lmwcorzuq6HVQF/vpBydtf4YBIcMhf
 4kxtkoLZq3IabpbL0LILrjO6h/TJlnlMJ+IMgy2eeQx2jNvYQ4PD+AXbvaaWwnSsOVi1
 PXxjnkMmx7ou5s0/oVe2YVNtNQoTDhys9nhYh4E5eCxyP50zVCeRCI818hD9KByA3Q4M
 hnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691534735; x=1692139535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4zoE2ZwVmHBor7Y96sjSCtAhah8L8hrknysTAlUT2V4=;
 b=UsrWUh6d88yfELmQs3AhBYHqJKRBvJdHJA8iUPLbNTAWv5tzCE++m46HBsPzdXb7yk
 br4uSthhQU0Q3jYuhk1/KhQV0ML64u/WlMOkaFlp96AxQ3LhXTiMHNilY87/ZKhJ8jhx
 4ixdJqcCJjxDned0C2my1OmaPGxIZHu/3FQ0/16KF2pfreYe6kCTOB9n4jDWxUCx6/FL
 S7qkxsaQGFPgveMhAd10nkT1tYFruO+5NAYsptSxIZuS+HljBRETOADefpuERHUezbqm
 fFFtCV+206h4ldmt1xNVF3ZdeqBqjog7jnFJBykMLqX8DxuF5QxZQcgFhHGeioduDpf5
 1TQA==
X-Gm-Message-State: AOJu0YyXfiDolvo5ViIvYBS7jL5m+ByyFcCzxEHa4ziQJv1tlRJiOCXZ
 JGep0nzRSGXz44rCgFGPXrqw3UkUt7XfsViNaH8=
X-Google-Smtp-Source: AGHT+IESA1vEkAb8NN1TKxScZTcfirIJcswPjC8o4gDaqNs+Sb0inq2cwg097aRc0ym8UTDBGOkMIA==
X-Received: by 2002:a05:6a20:12ca:b0:11f:4707:7365 with SMTP id
 v10-20020a056a2012ca00b0011f47077365mr1037172pzg.38.1691534734965; 
 Tue, 08 Aug 2023 15:45:34 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 x10-20020aa793aa000000b0064fde7ae1ffsm8581562pff.38.2023.08.08.15.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 15:45:34 -0700 (PDT)
Message-ID: <9c4fb0c5-7057-6fdc-b672-113bb9d1c8cd@linaro.org>
Date: Tue, 8 Aug 2023 15:45:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 38/38] tests/tcg: Add a test for info proc mappings
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
 <20230630180423.558337-39-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630180423.558337-39-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 6/30/23 11:04, Alex Bennée wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20230621203627.1808446-9-iii@linux.ibm.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
...
> +def run_test():
> +    """Run through the tests one by one"""
> +    try:
> +        mappings = gdb.execute("info proc mappings", False, True)
> +    except gdb.error as exc:
> +        exc_str = str(exc)
> +        if "Not supported on this target." in exc_str:
> +            # Detect failures due to an outstanding issue with how GDB handles
> +            # the x86_64 QEMU's target.xml, which does not contain the
> +            # definition of orig_rax. Skip the test in this case.
> +            print("SKIP: {}".format(exc_str))
> +            return
> +        raise
> +    report(isinstance(mappings, str), "Fetched the mappings from the inferior")
> +    report("/sha1" in mappings, "Found the test binary name in the mappings")

This test fails on ppc64 host, or indeed any host with page size != 4k.

When host page size != target page size, and the executable image is small, such as sha1, 
then target_mmap cannot directly map the executable file, but must implement the mmap via 
MAP_ANON + pread.  Which leaves us with no binary name in the host /proc/self/maps for us 
to copy to the artificial guest /proc/self/maps.

One of the very many issues with page size mismatch...

I'm tempted to remove the test, but I suppose we could check host page size in python.


r~



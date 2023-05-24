Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CADD670F709
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 14:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1o4g-0000sf-2F; Wed, 24 May 2023 08:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1o4d-0000sJ-DE
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1o4b-0001mP-R7
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684933116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rs9YqcnNIgDANKc6X4rAw0k8GMz8cXekZmlKpcm0coc=;
 b=Mjif9IxI360oO7rf9AhgW8o2Unv5v5IrBqCWNmh0C1h7gYxxitNIzYepEr3LtnsYRe1ce7
 usQqQur1JMnPUpxH+rxiMNrsf3/JVAXu+Kj8DtaW9kQ+2Zlq8CQqE9GasHvJXrsOFV/6SB
 O7E1hd26R39TJlv0ZddDwueuZK/BcTg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-tIxx8r5fNKuEZfsDGjAGuQ-1; Wed, 24 May 2023 08:58:26 -0400
X-MC-Unique: tIxx8r5fNKuEZfsDGjAGuQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96fffd1ba46so80439366b.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 05:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684933105; x=1687525105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rs9YqcnNIgDANKc6X4rAw0k8GMz8cXekZmlKpcm0coc=;
 b=FiyhmoAodEJ92CxqURLWoXNe1U0JSnreUwhhhwLVtOXqcjK3luxAIC7pyqD0e7tE78
 pHr2UfreYGpg83fOe32p6is3zAZ5AmqcL7LDwUvuyMfqiYuG1KQXXOMIA/U0rfdtsH3G
 REm19nOdHwOV3siO2T+NRBhDajft9XWjfSvOH5omAnxSTsrGzYzZV+CXQgjmmdatbc5s
 FyUb4GYhVufF/ckNUmrGoWs/kV7fZDGLYtea3pIpTiEbAqFoZDRY2USI5Y9YXK8qFmOV
 XrWzaSQ74ZZZUPct00U2aazRXhSRVw7Y5Q6j/ZlYODcF7ZxFUepxcjkzi3m3QcYoKTjy
 Zi2g==
X-Gm-Message-State: AC+VfDxlqoSpzmgwr/0MpWu5ioHeHvhlxp2TTFrzN4VkeJGbJ0zx18rA
 XVPkVQdACSeXbLpYqsvuYUQhjD+if3YhBLdLCU4m/FRVLMs8R67cgZWQhfQaTmv3A0y/u+6vugZ
 lXGdJxhux0z7p5Hg=
X-Received: by 2002:a17:907:25cd:b0:96f:678:d2fc with SMTP id
 ae13-20020a17090725cd00b0096f0678d2fcmr14684854ejc.22.1684933105103; 
 Wed, 24 May 2023 05:58:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lwPklRUoj2ApAOKUV9jU9b+Vbc9cm8O8ulUliS3XW7ecEnpYS0cgxGB24o/Ih65O2Sj2oHw==
X-Received: by 2002:a17:907:25cd:b0:96f:678:d2fc with SMTP id
 ae13-20020a17090725cd00b0096f0678d2fcmr14684837ejc.22.1684933104750; 
 Wed, 24 May 2023 05:58:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a?
 ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.googlemail.com with ESMTPSA id
 b3-20020a1709064d4300b009545230e682sm5733957ejv.91.2023.05.24.05.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 05:58:24 -0700 (PDT)
Message-ID: <5a80a536-8893-57d1-d094-4582e1492b3c@redhat.com>
Date: Wed, 24 May 2023 14:58:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tests/decode: Convert tests to meson
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20230523174848.682195-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230523174848.682195-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/23/23 19:48, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Hi Paolo, I've used "should_fail: true" because from the docs that
> seems like the proper thing, but that produces
> 
> 28/39 qemu:decodetree / err_width1  EXPECTEDFAIL  0.08s  exit status 1
> 
> which isn't nearly so reassuring as OK.  I wonder if it would be better
> to add a --test-fail switch to decodetree.py, to invert the exit value?

Yeah, the documentation is incorrect and it would need a
success_exitcode argument or something like that.  Maybe it's easier to
change the shell script to emit TAP, and use

   protocol: 'tap', verbose: true

in the test() invocation?

Should be as easy as

--- a/tests/decode/check.sh
+++ b/tests/decode/check.sh
@@ -1,24 +1,29 @@
-#!/bin/sh
+#!/bin/bash
  # This work is licensed under the terms of the GNU LGPL, version 2 or later.
  # See the COPYING.LIB file in the top-level directory.
  
  PYTHON=$1
  DECODETREE=$2
-E=0
+j=0
  
  # All of these tests should produce errors
  for i in err_*.decode; do
+    let j++
      if $PYTHON $DECODETREE $i > /dev/null 2> /dev/null; then
          # Pass, aka failed to fail.
-        echo FAIL: $i 1>&2
-        E=1
+        echo not ok $j $i
+    else
+        echo ok $j $i
      fi
  done
  
  for i in succ_*.decode; do
-    if ! $PYTHON $DECODETREE $i > /dev/null 2> /dev/null; then
-        echo FAIL:$i 1>&2
+    let j++
+    if $PYTHON $DECODETREE $i > /dev/null 2> /dev/null; then
+        echo ok $j $i
+    else
+        echo not ok $j $i
      fi
  done
  
-exit $E
+echo 1..$j



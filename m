Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF349BB452
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Nov 2024 13:13:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vwZ-0003ii-NO; Mon, 04 Nov 2024 07:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t7vwX-0003iX-Ck
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:12:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t7vwV-00067z-Kk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730722341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bzE2g84UC9kOQ6qrKuKWe/SXqaTOYIvF1JwgwEEAjtw=;
 b=a+dXw7SXo5cBDkGCQBgXnCk2Mt2e8p0/Mcbb798Re88A0ZG+U7t/nhpPGdDSd4j4XXzQ/B
 3fyZuNB/mrFNfhhLt5cpcmvJlYeey1q9rsD04jlTniBm0gpG68dwFdhF2FqZUUTQmUlZnF
 NvbPvphELwrxgjyZ0KJEGKbGey0MlAo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-7TMTMQIVPT-OId5PqRfvcQ-1; Mon, 04 Nov 2024 07:12:19 -0500
X-MC-Unique: 7TMTMQIVPT-OId5PqRfvcQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d563a1af4so1970173f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730722338; x=1731327138;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bzE2g84UC9kOQ6qrKuKWe/SXqaTOYIvF1JwgwEEAjtw=;
 b=UrUoUO4006e1bpaQciXmspnzdf9Cw93xdZB2HeW4euumCnd++Wwl4IkW3PZKPSXLgM
 QGNdQ9GKwDuCRn0O4wpD1TVLr5UkwQhyveWyT3VkerBsFKoh6PGfmc4pgwNLMRlfUs0B
 rH2WJXrVbyjF3JlMA+t69tSJbWtCBqj6rpwCAunDJGhfd2x3ETnNxalVpTMmRrPeYcXc
 eEsZM/CDcn1L6FAlkAHrsI3hfmY7yZTXI+DbAOg/dzxSQLHpOCHE2ve20jmR3snil7C8
 q46shsDDxaKDnDgaAR5Ev23ZTyXowB7l+fHw8Z+4Wswwuo0Yu1Dnb7IorncX95VcYIuC
 fOaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZP/UbT38krEo5uQtzUXtoDCE0IuLpEpi6HVDZRhrx6zAhUolpS+4hrF+6tQXzJGHbdz/ohGm9r49o@nongnu.org
X-Gm-Message-State: AOJu0YyGMyW0nPUk0aHLRv53Kjl3eHiCZOzHro5K+UHIoqPbKREjVMXt
 76LUKHQlHkkUVfO2GfruEn/0JIfdnGXTpwbA59v44IRywOW+qKppL0cEHjMP34vXzRWcK+pLDsI
 7V3X8IQNA4fs/Iacv6/t/qxFjQZSg6PMNUelRiQ21823BAZRleDPA
X-Received: by 2002:a5d:47ad:0:b0:37d:614e:2bc5 with SMTP id
 ffacd0b85a97d-381c7a5edcdmr9834378f8f.29.1730722338454; 
 Mon, 04 Nov 2024 04:12:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB/rP50tVQ7+OqQcEjM6j3JCyuvaBf/g7OIkwMPcGcClRvqjaMqAxUTSktv3fxn7DaEY00HA==
X-Received: by 2002:a5d:47ad:0:b0:37d:614e:2bc5 with SMTP id
 ffacd0b85a97d-381c7a5edcdmr9834352f8f.29.1730722338025; 
 Mon, 04 Nov 2024 04:12:18 -0800 (PST)
Received: from [10.33.192.239] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4387sm13062106f8f.42.2024.11.04.04.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 04:12:17 -0800 (PST)
Message-ID: <28eba1fd-f5d8-4755-b8bb-074d3c087a75@redhat.com>
Date: Mon, 4 Nov 2024 13:12:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: check-function failing on func-arm-arm_aspeed
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA_Z+o3HYfjapAeADAmjJqTYvswAfAbtj8i=3rSBDLwsyA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_Z+o3HYfjapAeADAmjJqTYvswAfAbtj8i=3rSBDLwsyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 28/10/2024 18.14, Peter Maydell wrote:
> Trying a "make check-functional" I find that the func-arm-arm_aspeed
> test seems to hit a timeout:
> 
> 18/18 qemu:func-thorough+func-arm-thorough+thorough /
> func-arm-arm_aspeed              TIMEOUT        600.08s   killed by
> signal 15 SIGTERM
> 
> This is with commit cea8ac78545a.

Cédric, is it working reliable for you?

> Does anybody else see this, or is it some oddity happening only
> on my local dev machine?
> 
> The "full log" in testlog-thorough.txt doesn't seem to be
> very full. All it has for this test is:
> 
> =================================== 18/18 ====================================
> test:         qemu:func-thorough+func-arm-thorough+thorough /
> func-arm-arm_aspeed
> start time:   16:54:50
> duration:     600.08s
> result:       killed by signal 15 SIGTERM
> command:      G_TEST_SLOW=1
> PYTHONPATH=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python:/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional
> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> MALLOC_PERTURB_=238
> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
> MESON_TEST_ITERATION=1
> QEMU_TEST_QEMU_IMG=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-img
> MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> QEMU_TEST_QEMU_BINARY=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-arm
> QEMU_BUILD_ROOT=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/python3
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_arm_aspeed.py
> ----------------------------------- stdout -----------------------------------
> TAP version 13
> ok 1 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_04
> ok 2 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_07
> ok 3 test_arm_aspeed.AST2x00Machine.test_arm_ast2400_palmetto_openbmc_v2_9_0
> ==============================================================================
> 
> Is it possible to get the log to include a pointer to the
> actual log for the test (including the guest console output)?
> It's hard to debug tests if they don't report what they're doing.

I tried to add something to the log iff the test case failed (e.g. by
checking defaultTestResult().wasSuccessful() or something similar in the
tearDown() function of the test), but that does not seem to work ...
so all I can suggest right now is to print out the path to the test log
unconditionally, something like:

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index aa0146265a..7436f37bc5 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -47,13 +47,14 @@ def setUp(self, bin_prefix):
          self.logdir = self.workdir
          self.log = logging.getLogger('qemu-test')
          self.log.setLevel(logging.DEBUG)
-        self._log_fh = logging.FileHandler(os.path.join(self.logdir,
-                                                        'base.log'), mode='w')
+        log_file_name = os.path.join(self.logdir, 'base.log')
+        self._log_fh = logging.FileHandler(log_file_name, mode='w')
          self._log_fh.setLevel(logging.DEBUG)
          fileFormatter = logging.Formatter(
              '%(asctime)s - %(levelname)s: %(message)s')
          self._log_fh.setFormatter(fileFormatter)
          self.log.addHandler(self._log_fh)
+        print(self.id() + ' log file: ' + log_file_name)
  
      def tearDown(self):
          self.log.removeHandler(self._log_fh)

Downside is that the message is also always printed if you e.g. run
"make check-functional V=1" ... does that still sound ok to you?

  Thomas



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C179D9D8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 22:00:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg9XG-000146-P6; Tue, 12 Sep 2023 15:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg9XA-00013y-6N
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg9X7-00088O-Kp
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694548728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcSR8eD6wuqm3dcdWHNcHbINB9N3mzJoohi1aoFi41w=;
 b=CnJgKAIE85FF99F1a1gHjrwisx67qfaQ9pwL1hFcqISmVt+C6fDnW1w5bSH4p2f225JF6V
 v7PWzoOW6/Ihhaode1zFzcFur4vZpN6a8pGsMw/qrbCuVFOa9fswUmrOIMkvmS2YPLWOkY
 wiYUVSBED+xC8nvhCv5TS/i2QifnKUM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-01fed6uAMWecKmWtUX9pvQ-1; Tue, 12 Sep 2023 15:58:45 -0400
X-MC-Unique: 01fed6uAMWecKmWtUX9pvQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31f9186eb8dso2228964f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 12:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694548723; x=1695153523;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FcSR8eD6wuqm3dcdWHNcHbINB9N3mzJoohi1aoFi41w=;
 b=l9Fv/dofYqfYf+KHWZbEQAYCsPaeLnvFKTYCqiegB46q5i4vTQUv05pSXFudGPMxaX
 JP2RcT3mmhfaQxeOu9IGsrv+CIVuuwdTQOUCw95g3eqo2eCtfZo4MAI5XOJM1xeMzuIP
 6xnjC5W15Gckd1R8Lx8fE5Xg+Rw2EqEVVIeW8sTogE9jOMbwrp9YI6msLbN9DsVB69IY
 LSvqTWijUpLShqGVaVylCAXKRf9AZDJwJf7ocINv1rfMjnPBNBvECmq3iGMVWnOvE3/R
 jawEWi5CK8aHX9dwa1DzWB8Lvo33Kfb1bRXPYxMUJmsGc40FNOGduSW3lb3jEi4xZmvM
 SScg==
X-Gm-Message-State: AOJu0Yw99qkzU329SU4TTe358zYEKU4+5pEkg92IUb9j+5rULP4mDdHb
 4zhiltzjiUV63giJF5xAs1WXsJ2q5ylg4RGJzujlf7LtCRM6awRnH4W0bq4qgGorT0DChLq/unh
 5ZaChXc07dwsz/n8=
X-Received: by 2002:a5d:45d0:0:b0:313:e9f6:3378 with SMTP id
 b16-20020a5d45d0000000b00313e9f63378mr411791wrs.4.1694548723776; 
 Tue, 12 Sep 2023 12:58:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF14U+P9YFurzyfHtTjZopKokBK1xAAZvR3jHTHPlpwqQNGrbjdQlO/IbbhHLQejLclq/Z/XQ==
X-Received: by 2002:a5d:45d0:0:b0:313:e9f6:3378 with SMTP id
 b16-20020a5d45d0000000b00313e9f63378mr411778wrs.4.1694548723420; 
 Tue, 12 Sep 2023 12:58:43 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-179-28.web.vodafone.de.
 [109.43.179.28]) by smtp.gmail.com with ESMTPSA id
 o14-20020a5d58ce000000b0031433443265sm13634386wrf.53.2023.09.12.12.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 12:58:42 -0700 (PDT)
Message-ID: <27e38912-0bad-7398-dda6-1670fc644f74@redhat.com>
Date: Tue, 12 Sep 2023 21:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230912150611.70676-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
In-Reply-To: <20230912150611.70676-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/09/2023 17.06, Stefan Hajnoczi wrote:
> The avocado-system-alpine, avocado-system-fedora, and
> avocado-system-ubuntu jobs are unreliable. I identified them while
> looking over CI failures from the past week:
> https://gitlab.com/qemu-project/qemu/-/jobs/5058610614
> https://gitlab.com/qemu-project/qemu/-/jobs/5058610654
> https://gitlab.com/qemu-project/qemu/-/jobs/5030428571
> 
> Thomas Huth suggest on IRC today that there may be a legitimate failure
> in there:
> 
>    th_huth: f4bug, yes, seems like it does not start at all correctly on
>    alpine anymore ... and it's broken since ~ 2 weeks already, so if nobody
>    noticed this by now, this is worrying
> 
> It crept in because the jobs were already unreliable.
> 
> I don't know how to interpret the job output, so all I can do is to
> propose removing these jobs. A useful CI job has two outcomes: pass or
> fail. Timeouts and other in-between states are not useful because they
> require constant triaging by someone who understands the details of the
> tests and they can occur when run against pull requests that have
> nothing to do with the area covered by the test.
> 
> Hopefully test owners will be able to identify the root causes and solve
> them so that these jobs can stay. In their current state the jobs are
> not useful since I cannot cannot tell whether job failures are real or
> just intermittent when merging qemu.git pull requests.
> 
> If you are a test owner, please take a look.
> 
> It is likely that other avocado-system-* CI jobs have similar failures
> from time to time, but I'll leave them as long as they are passing.
> 
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1884
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 27 ---------------------------
>   1 file changed, 27 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index aee9101507..83ce448c4d 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -22,15 +22,6 @@ check-system-alpine:
>       IMAGE: alpine
>       MAKE_CHECK_ARGS: check-unit check-qtest
>   
> -avocado-system-alpine:
> -  extends: .avocado_test_job_template
> -  needs:
> -    - job: build-system-alpine
> -      artifacts: true
> -  variables:
> -    IMAGE: alpine
> -    MAKE_CHECK_ARGS: check-avocado

Please don't remove the whole job! Just disable the failing tests within the job, e.g.:

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -503,6 +503,7 @@ def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
          console_pattern = 'Kernel command line: %s' % kernel_command_line
          self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
  
+    @skipIf(os.getenv('GITLAB_CI'), 'Skipping unstable test on GitLab')
      def test_mips_malta32el_nanomips_4k(self):
          """
          :avocado: tags=arch:mipsel
@@ -517,6 +518,7 @@ def test_mips_malta32el_nanomips_4k(self):
          kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
          self.do_test_mips_malta32el_nanomips(kernel_path_xz)
  
+    @skipIf(os.getenv('GITLAB_CI'), 'Skipping unstable test on GitLab')
      def test_mips_malta32el_nanomips_16k_up(self):
          """
          :avocado: tags=arch:mipsel
@@ -531,6 +533,7 @@ def test_mips_malta32el_nanomips_16k_up(self):
          kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
          self.do_test_mips_malta32el_nanomips(kernel_path_xz)
  
+    @skipIf(os.getenv('GITLAB_CI'), 'Skipping unstable test on GitLab')
      def test_mips_malta32el_nanomips_64k_dbg(self):
          """
          :avocado: tags=arch:mipsel



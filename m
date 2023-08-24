Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF57874ED
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:11:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCvC-0002CX-G6; Thu, 24 Aug 2023 12:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZCv2-00029i-PG
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZCuy-0002t9-40
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692893442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLzgfS7QQiHzDlVx5hvGZCnFjAtK2P0MUfcEMitmvSY=;
 b=JKs6VPvL00h56POEUTIO+0vOhlZ21cHcKjvK5nJLDlNCyKlVouD27jvlNM6oYOyC/xJ8JN
 6PKzNnvMZz+mFgs8seG5J8UCp4ov8CyTI43gG60DEMcSATgBf7Vh6sbw1xBVM7uVoJmkjk
 uW3jLXD3xeHcF42OCeN0OzOsP76n3M8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-dGc_R3tCPdSbdIlpgMKXfA-1; Thu, 24 Aug 2023 12:10:40 -0400
X-MC-Unique: dGc_R3tCPdSbdIlpgMKXfA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31c5adb698aso2789940f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692893439; x=1693498239;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLzgfS7QQiHzDlVx5hvGZCnFjAtK2P0MUfcEMitmvSY=;
 b=h2+0D/1977r5das4fl5ik7nUC2M0ryr8N3zxw5ijyQblM950mJYyFYnnXcaKrtgZKc
 jf2RBuEbOD7JZdw6GNqVxeS2HxyqTeBr4naheaVziKdGeQBhkdeC1fEjPI4jOGx12bLm
 SpQ1lEgf1EO4/3mrdEhxB0GvRfUlLhkYy/mrc2cPJLhVwp5A7Ri5Ug0AMrZCFJLDve26
 Tu8hAXdTJEvFVXeKfgTQQMeKbu2CJvoVnQaMii5wmEot4i6s4SwqxhT6379GmeknBLXu
 dKNmPvFYxUlzCciF8j4VkISpwmVZF6yPt3hq3VuZnTqB667d7OzaXwspbacj3oo9N7DP
 bUcw==
X-Gm-Message-State: AOJu0Yx5WMQYA+PAs24LfBq6POj9E6W5gexe+8Dolkn9AK/sr41CZgaz
 40EYAgreGpyri4uhurefvQote/zEu0yoqhIsY09LI5GPGg9ScJ+wVUX0mXU0cBM0NXQAwrPjIlm
 JSjbp+dxz6rzhUkA=
X-Received: by 2002:a5d:550c:0:b0:319:75e0:c49 with SMTP id
 b12-20020a5d550c000000b0031975e00c49mr11439664wrv.13.1692893439430; 
 Thu, 24 Aug 2023 09:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEJZ+pAHh5E/yXz2O2KRD1Igr/40mo51ApRL3mXSx/ts8PpVYrlt/zi2ioWkUFl0wdN4qBDg==
X-Received: by 2002:a5d:550c:0:b0:319:75e0:c49 with SMTP id
 b12-20020a5d550c000000b0031975e00c49mr11439655wrv.13.1692893439098; 
 Thu, 24 Aug 2023 09:10:39 -0700 (PDT)
Received: from [192.168.8.103] (tmo-099-164.customers.d1-online.com.
 [80.187.99.164]) by smtp.gmail.com with ESMTPSA id
 x9-20020a5d4909000000b0031c5e9c2ed7sm9777407wrq.92.2023.08.24.09.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 09:10:38 -0700 (PDT)
Message-ID: <e0b5f2d5-a489-a1b4-b630-987a2999a2b2@redhat.com>
Date: Thu, 24 Aug 2023 18:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/12] First batch of s390x patches for QEMU 8.2
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <20230823114544.216520-1-thuth@redhat.com>
 <20230823163440.GA851545@fedora>
 <aee5829f-37a4-4169-1a70-8f9a40b4f45d@redhat.com>
 <CAJSP0QXO1QQ=4UyLXg_=iyc9=uy1CdeL0fq8_95ewZiewU6XTw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAJSP0QXO1QQ=4UyLXg_=iyc9=uy1CdeL0fq8_95ewZiewU6XTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 24/08/2023 16.51, Stefan Hajnoczi wrote:
> On Thu, 24 Aug 2023 at 02:53, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 23/08/2023 18.34, Stefan Hajnoczi wrote:
>>> On Wed, Aug 23, 2023 at 01:45:32PM +0200, Thomas Huth wrote:
>>>> The following changes since commit b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa:
>>>>
>>>>     Open 8.2 development tree (2023-08-22 07:14:07 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     https://gitlab.com/thuth/qemu.git tags/pull-request-2023-08-23
>>>>
>>>> for you to fetch changes up to 6c49f685d30ffe81cfa47da2c258904ad28ac368:
>>>>
>>>>     tests/tcg/s390x: Test VSTRS (2023-08-23 12:07:30 +0200)
>>>
>>> Hi Thomas,
>>> Please take a look at the following ubuntu-20.04-s390x-all CI failure:
>>> https://gitlab.com/qemu-project/qemu/-/jobs/4931341536
>>
>> It says: "TimeoutError: Timeout waiting for job to pause" ... could you
>> please check the load on that host? ... I think that s390x runner is known
>> for being too slow some times, so I assume that problem should go away if
>> you re-run the job when it is less loaded.
> 
> I ran it again and it timed out. I've merged the PR and assume the
> test is just flaky.

I think someone needs to look at the runner to see whether there is still 
old stuff taking CPU time or something similar.

At least the two issues that occurred with the initial run ( 
qtest-i386/migration-test and io-qcow2-041) didn't reproduce in the follow 
up run here:

  https://gitlab.com/qemu-project/qemu/-/pipelines/979072973

(the ahci-test was failing instead)

  Thomas



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB01D763B40
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:39:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOecg-0005it-MH; Wed, 26 Jul 2023 09:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOecf-0005iP-1d
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 09:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOecd-000529-Dr
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 09:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690378329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLVtAEqRzGBV+IaqZEZ9f82jqorG7TangF4D2bjtulw=;
 b=KRPA9GZ0PcpG8fuHaCtvel+PM6jn5HZDu0sCBMQQJILMtZ1z+D01aq17ayW5aJoS+Lw/xP
 nEBYgVH9bVd6bYGQ26E/tkERTluBH+x+tQZizEy1O3NrA3JF/nwKcAOinsOj+NpBHSHBMZ
 jxA07GylJu+pHYvUnWt1B0i5I+boynQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-FSIHeRMQMlOR4_byvIXfUQ-1; Wed, 26 Jul 2023 09:32:08 -0400
X-MC-Unique: FSIHeRMQMlOR4_byvIXfUQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-314134f403fso3221762f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 06:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690378327; x=1690983127;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FLVtAEqRzGBV+IaqZEZ9f82jqorG7TangF4D2bjtulw=;
 b=blnFPw3B0KRO/aB/BoyvQOqP4mJ/UngFEal0mgQWlZBub75w/KGSnUFU/t3EfPPM8N
 507fUkwmnyuEBcWrKnslAeuYVVaTLcYZgrT1VBOKZvyyPiu5CcUkyNDALm0rc4Vc7aBU
 lXnRfmYS2M2/+eFJTfFApzq6HT83wsZERMlxSSoMfEpAwjmlxBMSKLpiD2vQIH/ADRez
 FijtkQ+iJkBKfRAOdVPWAC4ccBvlOl8snDrd+OHoZYnnH8wj4AV2rNJ3/hqC5O4zjHFy
 9LRuUHEZYoRYNfhkuSGFN9fN3N3es3P93DaHKF+e0bCU8dY+AaW4k7gxiz5YlFp2mtLs
 5uHA==
X-Gm-Message-State: ABy/qLZ2s9j29pxnCA3sKRa5ZbsRgSceiCKwsOdtRF7mS/LC4QQbC5Cp
 3e7MA3A3v9IEYLhyymOoWJ1CCzp3rC3n+TwfLfmtfSZgU6oGIer7kqlKUZcnL03y7Xs3l0QtopD
 Dg51RkBCsUEih67g=
X-Received: by 2002:a5d:6143:0:b0:317:759a:8ca8 with SMTP id
 y3-20020a5d6143000000b00317759a8ca8mr1723702wrt.67.1690378326823; 
 Wed, 26 Jul 2023 06:32:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFXJHifqfUVXF31jD3rdgXFVgzWNVwTzfH28Ap1C6igyu5/C0F6X/inDvaYMTAxYhfL2dXKVQ==
X-Received: by 2002:a5d:6143:0:b0:317:759a:8ca8 with SMTP id
 y3-20020a5d6143000000b00317759a8ca8mr1723679wrt.67.1690378326474; 
 Wed, 26 Jul 2023 06:32:06 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-0.web.vodafone.de. [109.43.176.0])
 by smtp.gmail.com with ESMTPSA id
 c1-20020adfe701000000b00311299df211sm19861338wrm.77.2023.07.26.06.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 06:32:06 -0700 (PDT)
Message-ID: <e68d2e2f-6afe-820b-fa45-44db5b6edf09@redhat.com>
Date: Wed, 26 Jul 2023 15:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, quintela@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, hreitz@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>,
 richard.henderson@linaro.org, Qemu-block <qemu-block@nongnu.org>
References: <87fs5aho6e.fsf@secure.mitica>
 <CAFEAcA89zgd+ZFBcMasTZErH6eTknXJhnDaXyW_LWj_vAYKrnw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: How to tame CI?
In-Reply-To: <CAFEAcA89zgd+ZFBcMasTZErH6eTknXJhnDaXyW_LWj_vAYKrnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/07/2023 15.00, Peter Maydell wrote:
> On Wed, 26 Jul 2023 at 13:06, Juan Quintela <quintela@redhat.com> wrote:
>> To make things easier, this is the part that show how it breaks (this is
>> the gcov test):
>>
>> 357/423 qemu:block / io-qcow2-copy-before-write                            ERROR           6.38s   exit status 1
>>>>> PYTHON=/builds/juan.quintela/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=44 /builds/juan.quintela/qemu/build/pyvenv/bin/python3 /builds/juan.quintela/qemu/build/../tests/qemu-iotests/check -tap -qcow2 copy-before-write --source-dir /builds/juan.quintela/qemu/tests/qemu-iotests --build-dir /builds/juan.quintela/qemu/build/tests/qemu-iotests
>> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>> stderr:
>> --- /builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-write.out
>> +++ /builds/juan.quintela/qemu/build/scratch/qcow2-file-copy-before-write/copy-before-write.out.bad
>> @@ -1,5 +1,21 @@
>> -....
>> +...F
>> +======================================================================
>> +FAIL: test_timeout_break_snapshot (__main__.TestCbwError)
>> +----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +  File "/builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-write", line 210, in test_timeout_break_snapshot
>> +    self.assertEqual(log, """\
>> +AssertionError: 'wrot[195 chars]read 1048576/1048576 bytes at offset 0\n1 MiB,[46 chars]c)\n' != 'wrot[195 chars]read failed: Permission denied\n'
>> +  wrote 524288/524288 bytes at offset 0
>> +  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +  wrote 524288/524288 bytes at offset 524288
>> +  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> ++ read failed: Permission denied
>> +- read 1048576/1048576 bytes at offset 0
>> +- 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +
> 
> This iotest failing is an intermittent that I've seen running
> pullreqs on master. I tend to see it on the s390 host. I
> suspect a race condition somewhere where it fails if the host
> is heavily loaded.

It's obviously a failure in an iotest, so let's CC: the corresponding people 
(done now).

  Thomas



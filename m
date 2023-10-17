Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBA77CBD3F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:21:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfJa-0007Gn-1p; Tue, 17 Oct 2023 04:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qsfJT-0007GM-07
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qsfJM-0003B5-LG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697530819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Pnv/D3/ZLtL1f8/oJdzJKMNl0b+QtA+JoG3aNJrpHS0=;
 b=JmYwfjdyJe6aRmF4sqXvh15UW7T18jagxQTTttHa4/efZIPRIMU9VlUA+320RLuFZK6qFD
 0MkdzVpdKaA3wTQlRfMGTiaI6aQlKCspZ0iYQEyEOpJU+M4m7HFoQXARpvFOs4EqfDNwWE
 oYshQdGBva9yhx3oQM1J2GIvuh1DakE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-zPYTPkeaPXyGK2F27FUMEA-1; Tue, 17 Oct 2023 04:20:18 -0400
X-MC-Unique: zPYTPkeaPXyGK2F27FUMEA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41b83b8dbe1so4890671cf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 01:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697530817; x=1698135617;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pnv/D3/ZLtL1f8/oJdzJKMNl0b+QtA+JoG3aNJrpHS0=;
 b=RlXk5raHJkaE8dd64V3rpe75tvcqHvfCX1nI63GjX9MKTnFF7w4bAA13sYtdtj4EIE
 sq1dLs1Wsu0s2v9zlBtDGLAOSFq8TIfGN+H/Ur0yFq6CBtltv6Ak+Zx0q+l3E9aYF/id
 XAUZjzZzXlYZt6+ryQlfl2hE6BkYwj7HossdhcgoDp4IB5ZHZm9/Uyo4FMLAtlVBZuW0
 5Zbzlx+pFqQAhXqYnCsmsbNUUIQt3LZwIh0Naug6T8IUbeHQlRKT6g0jhOB4PIPbXnLH
 0UB+HrFYGHQrPvK9jt4BtaWhh14TEF6s6NdngjkSvksxP21cF6SugDrx2NFhrTJQqNNI
 zLtg==
X-Gm-Message-State: AOJu0Yw+AMO8Wjx0lbu5O28JmUe9ZBUQSZOjNa8wU1SNfkc7bfQ+9rZx
 DPD31gY0o1aqGs8dUyFbtUQCzeZIFd7aaJx0uTTo9OqPZaHNCGqDCs0m6ZbW1DMazpwRZCQP3aX
 XT1n1Nu+wBuhRDqc=
X-Received: by 2002:ad4:5de7:0:b0:66d:44f2:7234 with SMTP id
 jn7-20020ad45de7000000b0066d44f27234mr1810059qvb.53.1697530817720; 
 Tue, 17 Oct 2023 01:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUjyHGuGBkejM8duNvuxFETzpkh9YpfebwfNXyRNH+B3zVChQwSrcwiZfbqXjjEGtlswQGYg==
X-Received: by 2002:ad4:5de7:0:b0:66d:44f2:7234 with SMTP id
 jn7-20020ad45de7000000b0066d44f27234mr1810034qvb.53.1697530817445; 
 Tue, 17 Oct 2023 01:20:17 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 kh13-20020a056214514d00b0065b17b925d0sm369035qvb.38.2023.10.17.01.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 01:20:17 -0700 (PDT)
Message-ID: <a2feb5e3-0d27-4e21-b80a-636f7c320fd2@redhat.com>
Date: Tue, 17 Oct 2023 10:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/38] Migration 20231016 patches
To: quintela@redhat.com, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20231016100706.2551-1-quintela@redhat.com>
 <CAJSP0QXkTvJnioak5X1Ya3CC6LmiriFqYhyUV+AJ4=JS4SK97w@mail.gmail.com>
 <877cnl3e52.fsf@secure.mitica>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <877cnl3e52.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 17/10/2023 09.24, Juan Quintela wrote:
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Mon, 16 Oct 2023 at 06:11, Juan Quintela <quintela@redhat.com> wrote:
>>>
>>> The following changes since commit 63011373ad22c794a013da69663c03f1297a5c56:
>>>
>>>    Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/alistair23/qemu into staging (2023-10-12 10:24:44 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/juan.quintela/qemu.git tags/migration-20231016-pull-request
>>>
>>> for you to fetch changes up to f39b0f42753635b0f2d8b00a26d11bb197bf51e2:
>>>
>>>    migration/multifd: Clarify Error usage in multifd_channel_connect (2023-10-16 11:01:33 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Migration Pull request (20231016)
>>>
>>> In this pull request:
>>> - rdma cleanups
>>> - removal of QEMUFileHook
>>> - test for analyze-migration.py
>>> - test for multifd file
>>> - multifd cleanups
>>> - available switchover bandwidth
>>> - lots of cleanups.
>>>
>>> CI: https://gitlab.com/juan.quintela/qemu/-/pipelines/1037878829
>>>
>>> Please, apply.
>>
>> This CI failure looks migration-related:
> 
> It is.
> 
>> MALLOC_PERTURB_=96
>> PYTHON=/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/pyvenv/bin/python3
>> QTEST_QEMU_BINARY=./qemu-system-i386
>> G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh
>> QTEST_QEMU_IMG=./qemu-img
>> QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon
>> /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qtest/migration-test
>> --tap -k
>> ――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
>> stderr:
>> **
>> ERROR:../tests/qtest/migration-test.c:1969:file_offset_finish_hook:
>> assertion failed (cpu_to_be32(*p) == QEMU_VM_FILE_MAGIC): (3 ==
>> 1363498573)
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/5301793548
> 
> But what I am doing wrong here?
> This time I even posnted the CI link that I passed O:-)
> 
> I thought that if I pass the:
> 
> $ git push -o ci.variable=QEMU_CI=2
> 
> on my branch, I was doing all the testing that you are doing.  Clearly
> not.

The failure happened on a s390x host, so nothing you can test by default [*] 
- these checks are only running in the qemu-project itself.

  Thomas


* If you still have a github repo, too, you can test with Travis-CI there, 
it features tests on s390x, aarch64 and ppc64le hosts.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8B7711A1F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 00:22:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2JJu-00026M-KE; Thu, 25 May 2023 18:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JN9vZAgKCssAr2B3srBx55x2v.t537v3B-uvCv2454x4B.58x@flex--talumbau.bounces.google.com>)
 id 1q2JJr-00024z-67
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:27 -0400
Received: from mail-il1-x14a.google.com ([2607:f8b0:4864:20::14a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JN9vZAgKCssAr2B3srBx55x2v.t537v3B-uvCv2454x4B.58x@flex--talumbau.bounces.google.com>)
 id 1q2JJo-0004P8-CN
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:26 -0400
Received: by mail-il1-x14a.google.com with SMTP id
 e9e14a558f8ab-33af162dd60so123015ab.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685053221; x=1687645221;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lW7y4qJlKlzhSJWIMQFrff7OxGsPmFUDFuf40mJjsoY=;
 b=UC+KaUyU0UC7vAfgs+RbIugHoedZwaTWa5FHM3MX9d+yT7JxKUQXjtq+zmbmDe3UXL
 CCp/9jzyB0oDYnmUHw/k182wLUYVv06be0f/cKDI4M8fT9m/B//QZc5c7wholVjYCFy7
 wq/xErh+pLc0zsePCbfIgpvDMiQFw1qlP27mgga5RM+x2VqnV+xMx/wd+bf6vdC1hiGk
 gW4L8TThr434cqEbIcHjiff3QfU5h/4cZ/NVQGAegDN+ACanKJtwNbGHQn1X8SBRTkyR
 lhsbpr1iSWwktE/grIcmCKWxTMeuuBFJGNM90NZSCAcoZ1rzksjJSEcwQxVFlHzKGi4K
 HZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685053221; x=1687645221;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lW7y4qJlKlzhSJWIMQFrff7OxGsPmFUDFuf40mJjsoY=;
 b=luq0KrcfR9k2QBeMmybHoDZYKevRshq6SE5FLtGqJnsER+zoRgbHdFCuLQwnefrj2M
 BJ5T7H3IjCViH9biwKqtrgtlhu6XR1WkbMbfQIy8O1XmKuhNzKIkorevZxOgc+fwC2XO
 1fgF4wt8qljhJ/pQDwTETy+sBcA4r7YUicikiwbncAXgXC381A3O14PEWnP3Z0YZ2NN+
 0h8/rQZtnxrzyHd20jF1F3Tdj9twXl8qB/tgm/ob8VVMmQL7fJ24TCs7cYSfVClYaLR/
 gEqjZtmuehmtpPF6mVhaQDNFXSJg900WTmdna3iOBzetiBFsmqEtfDQGNOjBRPTBjhjM
 YSNA==
X-Gm-Message-State: AC+VfDzKarT8a4U6Ge+/W1qcrqjN//BHJU48E6B420yjiZIpWte8pKxt
 Ets4B1ckQc0miXYRaT1xlGx6l11fhP3TN7NkreRa9n7Zwng7t+WTaRvctri5fJiB5K/a2Hptznm
 v57GLWoEPdtYIjbjb0ylcvnNQWKru+uSbf7J7gH1ykmPcHzf8+8w192qzJKCgWN4fFQ==
X-Google-Smtp-Source: ACHHUZ7DzRaGosZjcu0sXk7OJSWVAJw9Ugn6J6jxbWISpnduyvfskJWoYiZfiel9X1JA9CKbXD3UXMvtwxictA==
X-Received: from talumbau.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a92:ce8d:0:b0:331:66b3:5665 with SMTP id
 r13-20020a92ce8d000000b0033166b35665mr12099430ilo.5.1685053220838; Thu, 25
 May 2023 15:20:20 -0700 (PDT)
Date: Thu, 25 May 2023 22:20:11 +0000
Mime-Version: 1.0
Message-ID: <20230525222016.35333-1-talumbau@google.com>
Subject: [RFC PATCH v2 0/5] virtio-balloon: Working Set Reporting
From: "T.J. Alumbaugh" <talumbau@google.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Yuanchu Xie <yuanchu@google.com>, 
 Yu Zhao <yuzhao@google.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eric Blake <eblake@redhat.com>, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::14a;
 envelope-from=3JN9vZAgKCssAr2B3srBx55x2v.t537v3B-uvCv2454x4B.58x@flex--talumbau.bounces.google.com;
 helo=mail-il1-x14a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This is the device implementation for the proposed expanded balloon feature
described here:

https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu@google.com/

This series has a fixed number of "bins" for the working set report, but this is
not a constraint of the system. The bin number is fixed at device realization
time (in other implementations it is specified as a command line argument). Once
that number is fixed, this determines the correct number of bin intervals to
pass to the QMP/HMP function 'working_set_config'. Any feedback on how to
properly construct that function for this use case (passing a variable length
list?) would be appreciated.

New in V2:
=========

- Patch series is now: header file changes, device changes, QMP changes, HMP
chagnes, and migration changes.

- Exmaple usages of QMP and HMP interface are in their respective commit
messages.

- "ws" -> "working_set" throughout

Motivation
==========
As mentioned in the above message, the use case is a host with overcommitted
memory and 1 or more VMs. The goal is to get both timely and accurate
information on overall memory utilization in order to drive appropriate
reclaim activities, since in some client device use cases a VM might need a
significant fraction of the overall memory for a period of time, but then
enter a quiet period that results in a large number of cold pages in the
guest.

The balloon device now has a number of features to assist in sharing memory
resources amongst the guests and host (e.g free page hinting, stats, free page
reporting). As mentioned in slide 12 in [1], the balloon doesn't have a good
mechanism to drive the reclaim of guest cache. Our use case includes both
typical page cache as well as "application caches" with memory that should be
discarded in times of system-wide memory pressure. In some cases, virtio-pmem
can be a method for host control of guest cache but there are undesirable
security implications.

Working Set Reporting
=====================
The patch series here includes:

 - Actual device implementation for VIRTIO_F_WS_REPORTING to standardize the
   configuration and communication of Working Set reports from the guest. This
   includes a notification virtqueue for receiving config information and
   requests for a report (a feature which could be expanded for additional use
   cases) and a virtqueue for the actual report from the driver.

 - QMP changes so that a controller program can use the existing QEMU socket
   mechanism to configure and request WS reports and then read the reports as
   a JSON property on the balloon.

Working Set reporting in the balloon provides:

 - an accurate picture of current memory utilization in the guest
 - event driven reporting (with configurable rate limiting) to deliver reports
   during times of memory pressure.

The reporting mechanism can be combined with a domain-specific balloon policy
to drive the separate reclaim activities in a coordinated fashion.

TODOs:
======
 -  A synchronization mechanism must be added to the functions that send WS
    Config and WS Request, otherwise concurrent callers (through QMP) can mix
    messages on the virtqueue sending the data to the driver.

 - The device currently has a hard-coded setting of 4 'bins' for a Working Set
   report, whereas the specification calls for anywhere between 2 and 16.

 - A WS_EVENT notification through QMP should include the actual report,
   whereas right now we query for that information right after a WS_EVENT is
   received.

References:

[1] https://kvmforum2020.sched.com/event/eE4U/virtio-balloonpmemmem-managing-guest-memory-david-hildenbrand-michael-s-tsirkin-red-hat

T.J. Alumbaugh (5):
  virtio-balloon: Add Working Set Reporting feature
  virtio-balloon: device has Working Set Reporting
  virtio-balloon: Add QMP functions for Working Set
  virtio-balloon: Add HMP functions for Working Set
  virtio-balloon: Migration of working set config

 hmp-commands.hx                               |  26 ++
 hw/core/machine-hmp-cmds.c                    |  21 ++
 hw/virtio/virtio-balloon-pci.c                |   2 +
 hw/virtio/virtio-balloon.c                    | 239 +++++++++++++++++-
 include/hw/virtio/virtio-balloon.h            |  13 +-
 include/monitor/hmp.h                         |   2 +
 .../standard-headers/linux/virtio_balloon.h   |  20 ++
 include/sysemu/balloon.h                      |   9 +-
 monitor/monitor.c                             |   1 +
 qapi/machine.json                             |  66 +++++
 qapi/misc.json                                |  26 ++
 softmmu/balloon.c                             |  31 ++-
 12 files changed, 449 insertions(+), 7 deletions(-)

-- 
2.41.0.rc0.172.g3f132b7071-goog



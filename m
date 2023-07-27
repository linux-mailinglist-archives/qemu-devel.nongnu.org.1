Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE098765BE4
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 21:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP5l8-00084W-8q; Thu, 27 Jul 2023 14:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qP5kr-00084H-QG
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 14:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qP5kk-00006M-1j
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 14:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690482620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALx5gaT7IULtydMuY/ynqQ5oPR6SD3r6szW5tvnv1ho=;
 b=bI6g+n9Tdzv7zMYEUEuKNB1QJpPL06KZJbZWdc58ufheabvcdnt6Ecc4zinXYu9vjk6RXH
 Lxm07BnZDoSC6LXlhcSsEoBTHpDXO25XW6Qht+7bYRSFZDeeiv3u3AOgJQQJLvFvUviRxb
 Aym3ewfNv7kRHLqKVXWsHXM9q1DlfuI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-sI1O-HyDOfGLqX_K_x00jA-1; Thu, 27 Jul 2023 14:30:12 -0400
X-MC-Unique: sI1O-HyDOfGLqX_K_x00jA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbb0fdd060so7570555e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 11:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690482611; x=1691087411;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALx5gaT7IULtydMuY/ynqQ5oPR6SD3r6szW5tvnv1ho=;
 b=iOfLKRcOb1xPDoZjpsLSpYuCM4ydd7pt2dpuM05XPI10jNKrNGheb4f/mvsooh3C3A
 1mwULsCMDXQd1NZZercE0b8/n75GD8haxxNuR1CE1Yp1P1wiUNQsuxPYjQeoJi6pnAnS
 lmEPSAWtGtemdaQ+F//OXn3iZAvlsL9T1xIm67oaM/2uF5ozhO/AIi1fWcwFjcpjysXM
 cxGW/vMkhEeYjnEYAZ9ZuJSnqFGMg8hup+kHCfcat3QB962NEa2NTLmKtKGuEMXfM030
 0VWW/fDPh5qITZcX1k9fshnC8feQF9V8yAiktyAI1kyp0LF9VqDKFCRtdKOGntTGfpq6
 U7lQ==
X-Gm-Message-State: ABy/qLYG3QM9Y+ci7Mdb7d8/F6pzVBwZgj5uLiSmLeMylPSRSWv3UHtw
 GkO9uRrXYgiQtrOsiq2RosvFq/RJG1VXiHsAc5goq5ObeMjW4v2Oje0GeyyO7mpUI1QUaOyNtmm
 AZRXIqDwGKz5DmXk=
X-Received: by 2002:a05:600c:11cd:b0:3fb:b832:d79a with SMTP id
 b13-20020a05600c11cd00b003fbb832d79amr2480525wmi.38.1690482611508; 
 Thu, 27 Jul 2023 11:30:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYSk/be3cVPO7wufq1H+VYUFfKkSfzL5vEfqXUmFxro6hGhoqqqa8YIf3oBfiQPQI4FwFCQA==
X-Received: by 2002:a05:600c:11cd:b0:3fb:b832:d79a with SMTP id
 b13-20020a05600c11cd00b003fbb832d79amr2480512wmi.38.1690482611063; 
 Thu, 27 Jul 2023 11:30:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:4700:d2cd:2b81:d4e6:8b2a?
 (p200300d82f434700d2cd2b81d4e68b2a.dip0.t-ipconnect.de.
 [2003:d8:2f43:4700:d2cd:2b81:d4e6:8b2a])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a05600c20d100b003fba6709c68sm2394000wmm.47.2023.07.27.11.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 11:30:10 -0700 (PDT)
Message-ID: <e908495c-252c-745c-036b-1b19778435d9@redhat.com>
Date: Thu, 27 Jul 2023 20:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <20230726145912.88545-1-logoerthiner1@163.com>
 <183e16a8-55c3-7550-a9ff-21f31f65d0e5@redhat.com>
 <6bdbce7f.3e8e.18997f05e47.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] softmmu/physmem: try opening file readonly before
 failure in file_ram_open
In-Reply-To: <6bdbce7f.3e8e.18997f05e47.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 27.07.23 17:20, ThinerLogoer wrote:
> 
> At 2023-07-27 21:18:44, "David Hildenbrand" <david@redhat.com> wrote:
>> On 26.07.23 16:59, Thiner Logoer wrote:
>>> Users may give "-mem-path" a read only file and expect the file
>>> to be mapped read-write privately. Allow this but give a warning
>>> since other users may surprise when the ram file is readonly and
>>> qemu suddenly aborts elsewhere.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
>>> ---
>>>
>>> See the previous version at:
>>> https://lore.kernel.org/qemu-devel/96a462ec-6f9d-fd83-f697-73e132432ca4@redhat.com/T/
>>>
>>> verified, this patch works for my setup, both functionality and the warning
>>> are expected behavior.
>>>
>>> Also another problem when I look at the file_ram_open
>>>
>>> When readonly is true and the path is a directory, the open will succeed but
>>> any later operations will fail since it is a directory fd. This may require
>>> additional commits which is out of my scope. Merely record the question here.
> 
> Maybe you can notice this edge case? I am not sure whether this
> case is on your todo list?

I guess we would have to check if we opened a directory. Should be easy to add.

As long as QEMU fails reasonably well later, good for now :)

> 
>>>
>>>    softmmu/physmem.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>>> index 3df73542e1..e8279d69d4 100644
>>> --- a/softmmu/physmem.c
>>> +++ b/softmmu/physmem.c
>>> @@ -1296,6 +1296,7 @@ static int file_ram_open(const char *path,
>>>        char *sanitized_name;
>>>        char *c;
>>>        int fd = -1;
>>> +    bool first_trial = true;
>>>    
>>>        *created = false;
>>>        for (;;) {
>>> @@ -1332,6 +1333,18 @@ static int file_ram_open(const char *path,
>>>                    break;
>>>                }
>>>                g_free(filename);
>>> +        } else if (first_trial && !readonly && errno == EACCES) {
>>
>> I guess it's better to only retry on private mappings, for shared
>> mappings that cannot possibly work.
> 
> I feel that the retry can be applied in general - for shared mappings,
> it will merely fail on the mmap step and should be ok?

I guess a proper "can't open backing store" message is better for the cases that obviously can't work.

> 
> Though, to retry only on private mapping seems straightforwards -
> this function is called only once, and whether the mapping is private
> can be passed here with a boolean flag as argument. Nonetheless
> it may make the logic of the function more complex and less intuitive.

Quick untested attempt to move retry handling to the caller:

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1..c826bb78fc 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1289,8 +1289,7 @@ static int64_t get_file_align(int fd)
  static int file_ram_open(const char *path,
                           const char *region_name,
                           bool readonly,
-                         bool *created,
-                         Error **errp)
+                         bool *created)
  {
      char *filename;
      char *sanitized_name;
@@ -1334,10 +1333,7 @@ static int file_ram_open(const char *path,
              g_free(filename);
          }
          if (errno != EEXIST && errno != EINTR) {
-            error_setg_errno(errp, errno,
-                             "can't open backing store %s for guest RAM",
-                             path);
-            return -1;
+            return -errno;
          }
          /*
           * Try again on EINTR and EEXIST.  The latter happens when
@@ -1946,9 +1942,23 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
      bool created;
      RAMBlock *block;
  
-    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
-                       errp);
+    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created);
+    if (fd == -EACCES && !(ram_flags & RAM_SHARED) && readonly) {
+        /*
+         * We can have a writable MAP_PRIVATE mapping of a readonly file.
+         * However, some operations like ftruncate() or fallocate() might fail
+         * later, let's warn the user.
+         */
+        fd = file_ram_open(mem_path, memory_region_name(mr), true, &created);
+        if (fd >= 0) {
+            warn_report("backing store %s for guest RAM (MAP_PRIVATE) opened"
+                        " readonly because the file is not writable", mem_path);
+        }
+    }
      if (fd < 0) {
+        error_setg_errno(errp, -fd,
+                         "can't open backing store %s for guest RAM",
+                         mem_path);
          return NULL;
      }
  
-- 
2.41.0




-- 
Cheers,

David / dhildenb



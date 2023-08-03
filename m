Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8576F07C
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 19:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRbwk-0005Nn-Pa; Thu, 03 Aug 2023 13:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qRbwh-0005NM-TD
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 13:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qRbwg-0000RN-B0
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 13:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691083025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QrisBY64Flz187oTzSorgBXqABmRiRXy70E9Vsusiw=;
 b=UxPkpf3EI61l+uZhs1AJUgx1BNIOgalAcqNvX5m8sB/JAVx8YD7KWB9JjCdLCV9SQpi5qP
 5Cz/zQmVTPw3X/2C/xBovM7LIgywz/WBeRqGUWqekWl1B4Tj+VOZyDR1V0IIzvThjhnshn
 bDFEtnfEHHzEl5NEUligRgcmc/4fru0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-QEt79nVyOyWDLRPsR1qD8g-1; Thu, 03 Aug 2023 13:17:03 -0400
X-MC-Unique: QEt79nVyOyWDLRPsR1qD8g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe1d5e2982so7810305e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 10:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691083023; x=1691687823;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4QrisBY64Flz187oTzSorgBXqABmRiRXy70E9Vsusiw=;
 b=H8x4+O8+1iYvjBZars0wfOXN7PR0eJ7cTUgOWpb5qCMX6MPRtXvc5R2MfdOGgY3v/9
 cBzjnbOj0F1G1FlVP7exjDX7btGadmW3CIMPZtssvAwdZPo3ixs5LHsbEUx7dOUhAWpO
 ElyBFpx3fawOEzFaBhksy0QFZ+Hk0FUTXh77h/5T7If5InzzevX6IfLWyiTM+FhC0w6t
 cDHClHUp/KtuHFtgajEAfrW/MCj/Y5Fl/3SBW9ROK/bi/OK3OVINZqyWnV2bmMXYqstt
 LNNhvzfR7cSwY90cA183Fl9qfLAtOwvGPKO4W5hEPowiqgi/NcxueER/kwvmHhyAs5V1
 NDOQ==
X-Gm-Message-State: ABy/qLZ8s169j3DzoEG/puzh30dY8izi5+505dvXKV8msvyTXZjTiKC5
 y0g02yFpWQmeAj4AiTl9fTjYAzf0xvJcFs8MvZmPsfWH2f8HGpJcm9izzWhnjjC8YBZvd73kOq0
 UMlG0ZLpa5Q2TOWU=
X-Received: by 2002:a7b:c5c6:0:b0:3fa:9823:407 with SMTP id
 n6-20020a7bc5c6000000b003fa98230407mr7569716wmk.18.1691083022874; 
 Thu, 03 Aug 2023 10:17:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGLHsShlZLIJjR4fpZlx9vjJbYBbEEgfVq4qo9NGogCnBML2Q9bXdinf4p633AqIhr9sCxXuQ==
X-Received: by 2002:a7b:c5c6:0:b0:3fa:9823:407 with SMTP id
 n6-20020a7bc5c6000000b003fa98230407mr7569697wmk.18.1691083022429; 
 Thu, 03 Aug 2023 10:17:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9a00:a5f5:5315:b9fa:64df?
 (p200300cbc7189a00a5f55315b9fa64df.dip0.t-ipconnect.de.
 [2003:cb:c718:9a00:a5f5:5315:b9fa:64df])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a7bce08000000b003fbd9e390e1sm4707700wmc.47.2023.08.03.10.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 10:17:01 -0700 (PDT)
Message-ID: <b5578881-a953-d4e1-347a-41d31bfdc6fe@redhat.com>
Date: Thu, 3 Aug 2023 19:17:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Ping: Re: [PATCH v2] softmmu/physmem: try opening file readonly
 before failure in file_ram_open
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <20230726145912.88545-1-logoerthiner1@163.com>
 <183e16a8-55c3-7550-a9ff-21f31f65d0e5@redhat.com>
 <6bdbce7f.3e8e.18997f05e47.Coremail.logoerthiner1@163.com>
 <e908495c-252c-745c-036b-1b19778435d9@redhat.com>
 <615091df.3495.1899b089fc8.Coremail.logoerthiner1@163.com>
 <e2e82f40-2691-b947-bf06-bea0ded99eae@redhat.com>
 <358ce6fd.7806.189bc111547.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <358ce6fd.7806.189bc111547.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

On 03.08.23 17:43, ThinerLogoer wrote:
> At 2023-07-28 18:45:20, "David Hildenbrand" <david@redhat.com> wrote:
>>
>>
>> Whatever you prefer! If I resend the patch, I would keep you the author
>> and only add my Co-authored-by: Signed-off-by:.
>>
>> Just let me know.
>>
> 
> Hello,
> 
> I wonder whether you have planned to resubmit the current patch anytime soon, or is it already
> inside the patch queue?

I'm currently testing the following change on top, not compile-tested under
Windows, though.


 From b1abec2fe024ea90860ecf600c381e4a25e22ed8 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Thu, 3 Aug 2023 19:14:34 +0200
Subject: [PATCH] softmmu/physmem: Always detect and handle directories in
  file_ram_open()

open() does not fail on directories when opening readonly -- O_RDONLY.

To identify directories and handle them accordingly in file_ram_open()
also when readonly=true was specified, detect if we just opened a directory
using fstat() instead.

Before this change:

$ ./qemu-system-x86_64 \
     -object memory-backend-file,id=ram0,mem-path=tmp,readonly=true,size=1g
qemu-system-x86_64: unable to map backing store for guest RAM: No such device

With this change, it works as expected: we create a temporary hidden
file in that directory, just like when specifying readonly=false.

Reported-by: Thiner Logoer <logoerthiner1@163.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  softmmu/physmem.c | 24 ++++++++++++++++++++++--
  1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index d1ae694b20..32b51fd54d 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1300,9 +1300,29 @@ static int file_ram_open(const char *path,
      for (;;) {
          fd = open(path, readonly ? O_RDONLY : O_RDWR);
          if (fd >= 0) {
-            /* @path names an existing file, use it */
-            break;
+            /*
+             * open() won't fail when passing O_RDONLY on directories. So
+             * check manually if we're given a directory, and convert to
+             * EISDIR.
+             */
+            if (readonly) {
+                struct stat file_stat;
+
+                if (fstat(fd, &file_stat)) {
+                    close(fd);
+                    return -errno;
+                } else if (S_ISDIR(file_stat.st_mode)) {
+                    close(fd);
+                    fd = -1;
+                    errno = EISDIR;
+                }
+            }
+            if (fd >= 0) {
+                /* @path names an existing file, use it */
+                break;
+            }
          }
+
          if (errno == ENOENT) {
              /* @path names a file that doesn't exist, create it */
              fd = open(path, O_RDWR | O_CREAT | O_EXCL, 0644);
-- 
2.41.0


-- 
Cheers,

David / dhildenb



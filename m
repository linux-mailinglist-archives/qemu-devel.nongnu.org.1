Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B965DB51B4A
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 17:18:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwMYp-0003Eh-FT; Wed, 10 Sep 2025 11:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwMYg-0003EU-6j
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 11:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwMYd-0005O2-QC
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 11:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757517384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=4OxHkg67eoSGecCyYMjICLB7ktyHyklaAmb0Ib6YpWI=;
 b=RvR3CsyPnWTLtW1SsMXASO2qUvGpNiqM1wlhDPaNeGrurKKS4Tgdx0aOLwHGP6N+JhDHqH
 RCR5FLbPMzEhcwyoxUNYoIaBcN9HLIjI3yD+X8qyx96+IZKLW0ziaUCXskpRqX+NFbhzh1
 wWYkzEsExSsWau9/+6iUu42F1+oIC6I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-vibrCspyMbWMZ2oKdO5DzA-1; Wed, 10 Sep 2025 11:16:22 -0400
X-MC-Unique: vibrCspyMbWMZ2oKdO5DzA-1
X-Mimecast-MFC-AGG-ID: vibrCspyMbWMZ2oKdO5DzA_1757517381
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45cb6d8f42bso68196095e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 08:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757517381; x=1758122181;
 h=content-transfer-encoding:autocrypt:subject:cc:to:content-language
 :from:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4OxHkg67eoSGecCyYMjICLB7ktyHyklaAmb0Ib6YpWI=;
 b=WvmX17Gcdf1apyQRr3iEfcta/twkS56tbfB/HreEiUIe4DjmdApMymSxbjoWnblVi4
 kwTC3nbRE/P1EnoKKlFDJNPsT2wRPYOvWiiCodQlYSbjU6PSjsUtcBV8xHm6zcejR5+x
 s12agvoSqKlb2D8Ilb3zxw6I7K9nHV1hCHD1BxA6PxMHJnL0mI1HQTJL7iKcUl/IgNO/
 11vKWaUkC3YPq5ak1ADeI2F9YyFeuwLPsKYU2S2PnqmKGoiclYMFfWuwerwoMvAbAFzU
 oRoHrVw26zkcpSrNinJJRcdJ1XVJv0MHZ95kz1/eObLWFj/ZFtdtJTmRC9MeoGGhrbWm
 a5Sg==
X-Gm-Message-State: AOJu0Yz5gIJvXz+yiIGqaPLdOnLXGLNzNO2YxccTg2e1aDFD75PRH5a1
 S4aBWwy5gmb9RYYLM7IgRf6LUN7gu67KOUd7mNppy+we7s1Dadit5nwjxa780SEY4lW4p8s7jV/
 REyZE9ZWD+rofbWGyF0/FWq00VNLfAXoBwdyF3lbkV+/H/RUbOJMzPo2LbqCajmGYDOXWTFpHAN
 o72n2IHs5WDSm5M9URma7NDUUsw6DmCjsiPnpYRNo=
X-Gm-Gg: ASbGncuHdrDP3gbjC6lPSYzYGvkf0sYJeRhtaky3SFzQvKs0zXUR3CiGzVIaR9e4qhx
 oG6i+tNT78guwXnH5SS38xFXR3ZUrQv9Pc2vp1CN4UFqwt0HxGSUpNMGyhXSDMiisgdUO+3oFDx
 hHdkRr8H/IntXAfpFeBgm1eNshoFEDmP7Ub5pYbtpJoOJyW2eXkRwZ91WYAHkuUVjV7FlLOj3fx
 6xgVSEce3i3crJqoXJr/Z4peQm/FVCeh5O6wbN1joT8vZeUx+GTokE15BHv/IezGwdoysX2RBME
 VjtD0utDQrwHdxLDp7/YFtC7cpLgi9cHeKqOxPg644FTvcSV562tnCfCsfEoI2TV2yDk3Xk8X48
 /2If8nQ==
X-Received: by 2002:a05:600c:4f91:b0:45b:88d6:8db5 with SMTP id
 5b1f17b1804b1-45ddde82fc0mr142704165e9.12.1757517380708; 
 Wed, 10 Sep 2025 08:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8/SjfkxncUVKCAx88BuK42z3eCBwOvKRC5oItUXkvuYlI/AjaeAl/Rwk2DU47GKDz/sbN6A==
X-Received: by 2002:a05:600c:4f91:b0:45b:88d6:8db5 with SMTP id
 5b1f17b1804b1-45ddde82fc0mr142703785e9.12.1757517380124; 
 Wed, 10 Sep 2025 08:16:20 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45df18e9ae2sm29668345e9.11.2025.09.10.08.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Sep 2025 08:16:18 -0700 (PDT)
Message-ID: <425ef990-85cb-4c02-bb41-2f88f939d147@redhat.com>
Date: Wed, 10 Sep 2025 17:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 hreitz@redhat.com
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: Some iotests are failing with -luks
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


  Hi,

when running "./check -luks" in the qemu-iotests directory,
some tests are failing for me:

295 296 inactive-node-nbd luks-detached-header

Is that a known problem already?

FWIW, 295 is failing with the following output:

295   fail       [17:03:01] [17:03:17]   15.7s                failed, exit status 1
--- /home/thuth/devel/qemu/tests/qemu-iotests/295.out
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-295/295.out.bad
@@ -1,40 +1,326 @@
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
-{"return": {}}
-.{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
-{"return": {}}
-Job failed: Invalid password, cannot unlock any keyslot
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-.{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-Job failed: Refusing to overwrite active keyslot 2 - please erase it first
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
-{"return": {}}
-Job failed: All the active keyslots match the (old) password that was given and erasing them will erase all the data in the image irreversibly - refusing operation
-{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
-{"return": {}}
-.
+EWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
+EEWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=6 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
+EEWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=10 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
+E
+======================================================================
+ERROR: testChangeKey (__main__.EncryptionSetupTestCase.testChangeKey)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/295", line 204, in testChangeKey
+    self.addKeyQmp("testdev", new_secret = self.secrets[1])
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/295", line 159, in addKeyQmp
+    self.vm.cmd('x-blockdev-amend', **args)
+  File "/home/thuth/devel/qemu/python/qemu/machine/machine.py", line 735, in cmd
+    ret = self._qmp.cmd(cmd, **qmp_args)
+          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/python/qemu/qmp/legacy.py", line 214, in cmd
+    return self._sync(
+           ^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/python/qemu/qmp/legacy.py", line 102, in _sync
+    return self._aloop.run_until_complete(
+           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+  File "/usr/lib64/python3.11/asyncio/base_events.py", line 654, in run_until_complete
+    return future.result()
+           ^^^^^^^^^^^^^^^
+  File "/usr/lib64/python3.11/asyncio/tasks.py", line 452, in wait_for
+    return await fut
+           ^^^^^^^^^
+  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 632, in execute
+    return await self.execute_msg(msg)
+           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 574, in execute_msg
+    reply = await self._execute(msg)
+            ^^^^^^^^^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 496, in _execute
+    return await self._reply(exec_id)
+           ^^^^^^^^^^^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 463, in _reply
+    raise result
+qemu.qmp.qmp_client.ExecInterruptedError: Disconnected

etc.

296 looks very similar (also a "qemu received signal 6" error),
but the others look like this:

inactive-node-nbd   fail       [17:13:56] [17:14:04]   7.5s                 failed, exit status 1
--- /home/thuth/devel/qemu/tests/qemu-iotests/tests/inactive-node-nbd.out
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-inactive-node-nbd/inactive-node-nbd.out.bad
@@ -1,239 +1,64 @@
  Preparing disk...
  Launching VM...
-{"execute": "nbd-server-start", "arguments": {"addr": {"data": {"path": "SOCK_DIR/PID-nbd.sock"}, "type": "unix"}}}
-{"return": {}}
+ERROR:qemu.qmp.qmp_client.qemu-223907:Failed to receive Greeting: EOFError
+ERROR:qemu.qmp.qmp_client.qemu-223907:Failed to establish session: EOFError
+Traceback (most recent call last):
+  File "/home/thuth/devel/qemu/python/qemu/qmp/protocol.py", line 425, in _session_guard
+    await coro
+  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 250, in _establish_session
+    self._greeting = await self._get_greeting()
+                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 270, in _get_greeting
+    msg = await self._recv()
+          ^^^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/python/qemu/qmp/protocol.py", line 1009, in _recv
+    message = await self._do_recv()
+              ^^^^^^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 402, in _do_recv
+    msg_bytes = await self._readline()
+                ^^^^^^^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/python/qemu/qmp/protocol.py", line 977, in _readline
+    raise EOFError
+EOFError


and:

luks-detached-header   fail       [17:15:26] [17:15:38]   12.2s                failed, exit status 1
--- /home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached-header.out
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-luks-detached-header/luks-detached-header.out.bad
@@ -1,5 +1,55 @@
-..
+EE
+======================================================================
+ERROR: test_detached_luks_header (__main__.TestDetachedLUKSHeader.test_detached_luks_header)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached-header", line 139, in setUp
+    res = qemu_img_create(
+          ^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line 278, in qemu_img_create
+    return qemu_img('create', *args)
+           ^^^^^^^^^^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line 261, in qemu_img
+    return qemu_tool(*full_args, check=check, combine_stdio=combine_stdio)
+           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line 241, in qemu_tool
+    raise VerboseProcessError(
+qemu.utils.VerboseProcessError: Command '('/home/thuth/tmp/qemu-build/qemu-img', 'create', '-f', 'luks', '-o', 'iter-time=10', '-o', 'key-secret=sec0', '-o', 'detached-header=true', '--object', 'secret,id=sec0,data=foo', '/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-luks-detached-header/detached_header.img2')' returned non-zero exit status 1.
+  ┏━ output ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
+  ┃ Formatting '/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/l
+  ┃ uks-file-luks-detached-header/detached_header.img2', fmt=luks
+  ┃ size=-1 key-secret=sec0 iter-time=10 detached-header=true
+  ┃ qemu-img: /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luk
+  ┃ s-file-luks-detached-header/detached_header.img2: Parameter
+  ┃ 'detached-header' is unexpected
+  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


Any ideas?

  Thomas



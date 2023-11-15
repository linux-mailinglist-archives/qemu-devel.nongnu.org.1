Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE277EBEF7
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 10:01:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BkX-0000oh-SP; Wed, 15 Nov 2023 03:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3BkR-0000nb-Ty; Wed, 15 Nov 2023 03:59:49 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3BkQ-000493-0p; Wed, 15 Nov 2023 03:59:47 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 89A38336B5;
 Wed, 15 Nov 2023 12:00:00 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id ED1AE353A1;
 Wed, 15 Nov 2023 11:59:40 +0300 (MSK)
Message-ID: <6d464c16-6108-47c9-bd3d-81bd0944764f@tls.msk.ru>
Date: Wed, 15 Nov 2023 11:59:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 06/21] docs/devel/migration.rst: spelling fix:
 doen't
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Juan Quintela <quintela@redhat.com>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-7-mjt@tls.msk.ru>
 <f2bfef4a-3a2c-4d32-adf6-52317f85a045@redhat.com>
 <7259b384-cc7f-4400-9891-83e656765ce2@tls.msk.ru>
 <dcd5e473-7598-478e-8597-9efec38a4ba8@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <dcd5e473-7598-478e-8597-9efec38a4ba8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

15.11.2023 09:46, Thomas Huth:
..
>> The "really-really-fixed" one (without resending):
>>
>> -  This combination is not possible as the qemu-5.1 doen't understand
>> +  This combination is not possible as the qemu-5.1 doesn't understand
>>     pc-5.2 machine type.  So nothing to worry here.
>>
>> ;)

Actually there's more in there than this 1 fix: the change has
other fixes too, and one of them is in heading, so "underline"
in the next line should be fixed too.

These spelling fixes are.. tough :)  Lemme see if I did multiple
changes like this somewhere else, pretending there's just one fix..

Actual commit (with your R-b tag still, as apparently you reviewed
all changes).
With updated Subject, new Fixes: tag, and a change in heading underlining):

From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue Nov 14 19:08:48 2023 +0300

     docs/devel/migration.rst: spelling fixes: doen't, diferent, responsability, recomend

     Fixes: 593c28c02c81 "migration/doc: How to migrate when hosts have different features"
     Fixes: 1aefe2ca1423 "migration/doc: Add documentation for backwards compatiblity"
     Reviewed-by: Thomas Huth <thuth@redhat.com>
     Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 5adf4f12f7..ec55089b25 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -1061,7 +1061,7 @@ QEMU version, in this case pc-5.1.

  4 - qemu-5.1 -M pc-5.2  -> migrates to -> qemu-5.1 -M pc-5.2

-  This combination is not possible as the qemu-5.1 doen't understand
+  This combination is not possible as the qemu-5.1 doesn't understand
    pc-5.2 machine type.  So nothing to worry here.

  Now it comes the interesting ones, when both QEMU processes are
@@ -1214,8 +1214,8 @@ machine types to have the right value::
           ...
       };

-A device with diferent features on both sides
----------------------------------------------
+A device with different features on both sides
+----------------------------------------------

  Let's assume that we are using the same QEMU binary on both sides,
  just to make the things easier.  But we have a device that has
@@ -1294,12 +1294,12 @@ Host B:

  $ qemu-system-x86_64 -cpu host,taa-no=off

-And you would be able to migrate between them.  It is responsability
+And you would be able to migrate between them.  It is responsibility
  of the management application or of the user to make sure that the
  configuration is correct.  QEMU doesn't know how to look at this kind
  of features in general.

-Notice that we don't recomend to use -cpu host for migration.  It is
+Notice that we don't recommend to use -cpu host for migration.  It is
  used in this example because it makes the example simpler.

  Other devices have worse control about individual features.  If they



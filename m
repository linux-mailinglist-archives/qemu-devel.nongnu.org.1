Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C6B7C5675
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZwd-0005ZL-PZ; Wed, 11 Oct 2023 10:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZwX-0005UG-8H
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZwU-0008Oi-Kw
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697033524;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vLsR46dWXgtRjZ/415Qw5rW9dJFZG2bH32X3/0ZtKgU=;
 b=h8NvoIugvRBubBncP5DgG7YP++Fuso307ack2mEuwIur9Yh4RLkoHQCwrvAIgzjL0iCnjz
 6OUtK3a75t8pHrLQgpbL2+lKh5tBM3mUJ0Bngj6R89FpPlWZ81O0HtNBdp2Q/MZy+r2se9
 w1khk1QTmFNAk8mCDmRG0a+qbrGkVIM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-BPcjvBvTMO2DOC5LQYs6Wg-1; Wed, 11 Oct 2023 10:12:01 -0400
X-MC-Unique: BPcjvBvTMO2DOC5LQYs6Wg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d1ba32c95so1135292f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697033520; x=1697638320;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLsR46dWXgtRjZ/415Qw5rW9dJFZG2bH32X3/0ZtKgU=;
 b=BrwRg0KrqUP0dzV6QrpaXIEa+A9l4TpD+ANgRwCphO0F9YkHDK8/J6i6RnMPk70FeX
 522zeUPOQyihQlK8seeYrkOZy6MBsebSoHJ0BIZrlRzSWCbKLcti06WNnxQFxXFIWXZH
 reGH8xaHfZdZTZIXPaRYYVtGAm5K4NVR0PZW4XCnuuzNCyeyXiHxWuoH0r5iteD7Z6dW
 4UxCes/w4SySVy7Icv4B4W0Px7MpNKcJ31XGrn+36HhF3NjShmd6ugqTqE67vU2FAoXl
 vKWn1vBtRY1fLktB67iglHSNs4IF07QhgugCzpuIOFbKq1xRJRSXOM2dBGl0R4cRBe8w
 aTOQ==
X-Gm-Message-State: AOJu0YxW2BgjqWXE3VQWVTepW956REMev/DApxraBPgs6m3imtYQZTwQ
 mx8gBOa2b/GU+m2kzWU2bbAH45UGt43Jqz2XoaP9kB9U3HkzxROg7pRD86Em14p7QQbCOCxIkyJ
 sU6i7jVk5CA2phxs=
X-Received: by 2002:a5d:50c8:0:b0:316:f24b:597a with SMTP id
 f8-20020a5d50c8000000b00316f24b597amr18478425wrt.46.1697033520396; 
 Wed, 11 Oct 2023 07:12:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgb5uwesUJN9uHm4jfem7aO+/es1TabeIzwDjdFAFhzLNC5SeaEFy9A+F95lsbg6VDczLxnA==
X-Received: by 2002:a5d:50c8:0:b0:316:f24b:597a with SMTP id
 f8-20020a5d50c8000000b00316f24b597amr18478402wrt.46.1697033520045; 
 Wed, 11 Oct 2023 07:12:00 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 19-20020a05600c025300b00401d8181f8bsm19230663wmj.25.2023.10.11.07.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:11:59 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Li
 Zhijian <lizhijian@fujitsu.com>,  Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 06/65] tests/qtest: migration: Add support for negative
 testing of qmp_migrate
In-Reply-To: <87wmvt1fb2.fsf@suse.de> (Fabiano Rosas's message of "Wed, 11 Oct
 2023 10:04:01 -0300")
References: <20231011092203.1266-1-quintela@redhat.com>
 <20231011092203.1266-7-quintela@redhat.com> <87wmvt1fb2.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:11:58 +0200
Message-ID: <87edi19rkh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> From: Fabiano Rosas <farosas@suse.de>
>>
>> There is currently no way to write a test for errors that happened in
>> qmp_migrate before the migration has started.
>>
>> Add a version of qmp_migrate that ensures an error happens. To make
>> use of it a test needs to set MigrateCommon.result as
>> MIG_TEST_QMP_ERROR.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Message-ID: <20230712190742.22294-6-farosas@suse.de>
>> ---
>
> Hi Juan,
>
> What's the plan for the last patch in that series? The one that adds the
> actual test:
> [PATCH v5 6/6] tests/qtest: migration-test: Add tests for file-based migration
> https://lore.kernel.org/r/20230712190742.22294-7-farosas@suse.de
>
> I'm trying to keep track of what's merged and what's not because I have
> more patches on top of it to send.

You need to resend the patches that I didn't pick.

If my memory is correct, it didn't apply or make check didn't work without all
patches applied.

Later, Juan.



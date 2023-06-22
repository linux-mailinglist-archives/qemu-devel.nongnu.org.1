Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DB073A807
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 20:17:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOrr-0002kS-Ta; Thu, 22 Jun 2023 14:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCOrp-0002kA-W9
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 14:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCOro-0003J8-Cs
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 14:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687457831;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=R98ZaD+eZbGWBFxO/DBSZjvmhqViUT0xi1cQ6t9Wi0c=;
 b=HSBGrbBur7J/5DKxx254FF5/yWjQ9z1HFX8Ry7b786ej2ZPdWZwz6cQGXBumi66pxenu9Y
 yZO6IKixiEjYCN2yKbYQ1kvQqjziM6FelgatU/u5p4Z/owDicPL1ZVhYrYJba+IBZwVxfI
 MhcNGAtc5cvJzsDw47xzKuqRf32LA10=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-lLJnVN3nO7Wc6eon8PSWew-1; Thu, 22 Jun 2023 14:17:09 -0400
X-MC-Unique: lLJnVN3nO7Wc6eon8PSWew-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b46bfa6710so49178191fa.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 11:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687457828; x=1690049828;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R98ZaD+eZbGWBFxO/DBSZjvmhqViUT0xi1cQ6t9Wi0c=;
 b=d/Bg1FPkMyrX42k55q5ueCjWLZKZ5nRqooHPuIVH0wPzvHhbteq9vOF3PRsOezFBQp
 w2qrvx/gm+4ypRWvoUQJNIeKDe/+HzypUw6VQ4//p6OverNiprNFcw05S5cyjEtnB4kW
 hqt04uU5JgxE988JYgGPKywHDZJblHnNw74lDlEoHVRNmto+uW6Lh8HT12+jD2llZflf
 eJ+2CH63qAPLCMlvYf9vpFw6LEv+H+S4dfxMmiMrM4etLO8u7j5OzZLRph05jXQFdguU
 8euNSSxplQX+yagY3MsrisZZx/GAG3oFKS2ESN7QkaIx+UtvXphL47TDFlxcV8iw+Yho
 FL6Q==
X-Gm-Message-State: AC+VfDyLT+2vBkGd3XY/SL81Lfh8xM5h+CJQwCL8yeAnGUf0uitIScv0
 wIDGnd7mOd/MqyybLTL2d08gsxIVcRjIj/y7sGnXrgxjhxoN+zTEFNC87igMTL/jVdP/Nf6H7M3
 J4hDnkJpaEhrlgKU=
X-Received: by 2002:a05:6512:31c7:b0:4f9:5cb9:5be5 with SMTP id
 j7-20020a05651231c700b004f95cb95be5mr4060973lfe.65.1687457828269; 
 Thu, 22 Jun 2023 11:17:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HJKAIjBUPTHigek842x2ku9FdOjcZN/FQmO5zOA2GnGVN7zo5i0jmQBaPgJ4ZtNWG6Jr0bA==
X-Received: by 2002:a05:6512:31c7:b0:4f9:5cb9:5be5 with SMTP id
 j7-20020a05651231c700b004f95cb95be5mr4060961lfe.65.1687457827963; 
 Thu, 22 Jun 2023 11:17:07 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 u25-20020a05600c211900b003fa74bff02asm155751wml.26.2023.06.22.11.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 11:17:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Thomas Huth
 <thuth@redhat.com>,  libvir-list@redhat.com,  Paolo Bonzini
 <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Czenczek
 <hreitz@redhat.com>
Subject: Re: [RFC 5/6] migration: Deprecate block migration
In-Reply-To: <20230621114534.GA2681260@fedora> (Stefan Hajnoczi's message of
 "Wed, 21 Jun 2023 13:45:34 +0200")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-6-quintela@redhat.com>
 <20230621114534.GA2681260@fedora>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 20:17:06 +0200
Message-ID: <87sfaje50d.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Mon, Jun 12, 2023 at 09:33:43PM +0200, Juan Quintela wrote:
>> It is obsolete.  It is better to use driver_mirror+NBD instead.
>> 
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Hanna Czenczek <hreitz@redhat.com>
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> ---
>> 
>> Can any of you give one example of how to use driver_mirror+NBD for
>> deprecated.rst?
>
> Please see "QMP invocation for live storage migration with
> ``drive-mirror`` + NBD" in docs/interop/live-block-operations.rst for a
> detailed explanation.

You put here drive-mirror, and everything else blockdev-mirror.

It appears that blockdev-mirror is the new name from driver-mirror, but
as the documentation says driver-mirror + NBD, I am changing to
driver-mirror everywhere?

Thanks, Juan.



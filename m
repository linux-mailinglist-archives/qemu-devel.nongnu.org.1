Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1097F4A02
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 16:14:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ouK-0006PV-H7; Wed, 22 Nov 2023 10:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r5ouB-0006Mz-Q2
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 10:12:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r5ou7-0006EU-Pd
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 10:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700665958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kaXj/mWXJ9iD6nKFimcOBcHU6CqgZmufrMLvMDqaLPM=;
 b=hQs0t5oTBn/EwXu5iSShkdjDbYRS+AQT5OruinJMKkq+6hM0VA6EE1H2XKg87D5hNeo+qB
 lGVGxvsZMDHK7N2JWqZsABq6DKSfZZaRjOy1PQFe1aj4s36+/ZuWThQ/snrqMu/SnN7KnT
 9jwBRA2PWtfazilC4I95ZfqlY9cjylk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-GpoKonhKM6KOL43AwHj2SQ-1; Wed,
 22 Nov 2023 10:12:34 -0500
X-MC-Unique: GpoKonhKM6KOL43AwHj2SQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 002C7280AA28;
 Wed, 22 Nov 2023 15:12:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1C4D492BFA;
 Wed, 22 Nov 2023 15:12:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6F4031800394; Wed, 22 Nov 2023 16:12:32 +0100 (CET)
Date: Wed, 22 Nov 2023 16:12:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, graf@amazon.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 03/16] hw/uefi: add include/hw/uefi/var-service.h
Message-ID: <gwrbpgv2ylc5fdfy4f6pjctft3kf3w75ksxvxocyc2whdtruvf@suvmqrdwbghb>
References: <20231115151242.184645-1-kraxel@redhat.com>
 <20231115151242.184645-4-kraxel@redhat.com>
 <a41a545b-c78e-f261-6f8e-e4d7ffe94767@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a41a545b-c78e-f261-6f8e-e4d7ffe94767@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> > +struct uefi_var_policy {
> > +    variable_policy_entry             *entry;
> > +    uint32_t                          entry_size;
> > +    uint16_t                          *name;
> > +    uint32_t                          name_size;
> > +    uint32_t                          hashmarks;
> > +    QTAILQ_ENTRY(uefi_var_policy)     next;
> > +};
> 
> - I wonder if the size fields should be size_t. uint32_t is not wrong
> either; we'll just have to be careful when doing comparisons etc.

I can't store size_t in vmstate ...

> - care to explain (in a comment) hashmarks? I think it's related to the
> wildcard policy stuff, but a hint would be appreciated.

Yes.  It's the number of hashmarks, used when sorting entries by
priority.  Most specific match, i.e. smallest number of wildcard
characters, goes first.

I'll add a comment.

> > +struct uefi_vars_state {
> > +    MemoryRegion                      mr;
> > +    uint16_t                          sts;
> > +    uint32_t                          buf_size;
> > +    uint32_t                          buf_addr_lo;
> > +    uint32_t                          buf_addr_hi;
> 
> spelling out endianness here would be useful IMO

Don't think this is needed, qemu handles this for us.  The memory
region is declared to be little endian, qemu will convert reads/writes
to native endian for us, so there are no endian worries for the register
interface (the transfer buffer in guest ram is a different story).

> > +    /* boot phases */
> > +    bool                              end_of_dxe;
> > +    bool                              ready_to_boot;
> > +    bool                              exit_boot_service;
> 
> There are some variations of the 8 possible that don't make sense. at
> the same time, a single enum could be too limiting. depends on what the
> code will do with these.

end-of-dxe: used by variable policies (they are enforced only after that
event).

ready-to-boot: not used yet (other than setting it when the event arrives).

exit-boot-service: access control (RT vs. BT etc).

> > +/* vars-service-guid.c */
> > +extern QemuUUID EfiGlobalVariable;
> > +extern QemuUUID EfiImageSecurityDatabase;
> > +extern QemuUUID EfiCustomModeEnable;
> > +extern QemuUUID EfiSecureBootEnableDisable;
> > +extern QemuUUID EfiSmmVariableProtocolGuid;
> > +extern QemuUUID VarCheckPolicyLibMmiHandlerGuid;
> > +extern QemuUUID EfiEndOfDxeEventGroupGuid;
> > +extern QemuUUID EfiEventReadyToBootGuid;
> > +extern QemuUUID EfiEventExitBootServicesGuid;
> 
> the spelling of these names appears a bit questionable:
> 
> - camelcase is idiomatic in edk2, but (I think?) not in QEMU, for variables
> 
> - the "Guid" suffix is inconsistently used / carried over from edk2

Yes.  It's carried over from edk2.

We don't have to keep the names in qemu, in fact I've renamed the
structs because that would have been too much of a contrast to the
qemu code style, so the edk2 name is only noted in a comment in the
vars-service-edk2.h header file.

For the #defines and GUIDs I've kept the edk2 names as-is, so it's
easier to follow the control flow for people which are familiar with
edk2.  We have already have simliar stuff else, for example the struct
names in hw/usb/desc.h follow the usb spec not qemu code style.

take care,
  Gerd



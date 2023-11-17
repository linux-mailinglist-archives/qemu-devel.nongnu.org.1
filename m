Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F26187EF431
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 15:13:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zZS-0002zI-WF; Fri, 17 Nov 2023 09:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r3zZR-0002yt-8F
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r3zZP-0002Do-D1
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700230301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=usiL2lHe2AK65DsOZ/8Ygh8JDYZPAUL0m68vZU89Oxg=;
 b=ip/q/36lCUwaocmytbITOVl/KIG7qL/zA1sdeCv2ofy+qjWOMs3Mjz0Ig8OaIySXUt4LIT
 2ECAHNd9pWaQnYNLMifXKTO9LdbBXHliMaiaKqgwN3QbxYWVA6b1TtoHJcG0P6Zks173MH
 vdge1/C5U9yxhC4khFx0gOB08LwIOd4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-kPwlT3d_MI2u88Vm16xHPw-1; Fri,
 17 Nov 2023 09:11:36 -0500
X-MC-Unique: kPwlT3d_MI2u88Vm16xHPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 030703823329;
 Fri, 17 Nov 2023 14:11:36 +0000 (UTC)
Received: from [10.39.193.21] (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D50E51C060B0;
 Fri, 17 Nov 2023 14:11:33 +0000 (UTC)
Message-ID: <a41a545b-c78e-f261-6f8e-e4d7ffe94767@redhat.com>
Date: Fri, 17 Nov 2023 15:11:32 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 03/16] hw/uefi: add include/hw/uefi/var-service.h
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, graf@amazon.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20231115151242.184645-1-kraxel@redhat.com>
 <20231115151242.184645-4-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231115151242.184645-4-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/15/23 16:12, Gerd Hoffmann wrote:
> Add state structs and function declarations for the uefi-vars device.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/uefi/var-service.h | 119 ++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 include/hw/uefi/var-service.h
> 
> diff --git a/include/hw/uefi/var-service.h b/include/hw/uefi/var-service.h
> new file mode 100644
> index 000000000000..2b8d3052e59f
> --- /dev/null
> +++ b/include/hw/uefi/var-service.h
> @@ -0,0 +1,119 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * uefi-vars device - state struct and function prototypes
> + */
> +#ifndef QEMU_UEFI_VAR_SERVICE_H
> +#define QEMU_UEFI_VAR_SERVICE_H
> +
> +#include "qemu/uuid.h"
> +#include "qemu/queue.h"
> +
> +#include "hw/uefi/var-service-edk2.h"
> +
> +#define MAX_BUFFER_SIZE (64 * 1024)
> +
> +typedef struct uefi_variable uefi_variable;
> +typedef struct uefi_var_policy uefi_var_policy;
> +typedef struct uefi_vars_state uefi_vars_state;
> +
> +struct uefi_variable {
> +    QemuUUID                          guid;
> +    uint16_t                          *name;
> +    uint32_t                          name_size;
> +    uint32_t                          attributes;
> +    void                              *data;
> +    uint32_t                          data_size;
> +    QTAILQ_ENTRY(uefi_variable)       next;
> +};
> +
> +struct uefi_var_policy {
> +    variable_policy_entry             *entry;
> +    uint32_t                          entry_size;
> +    uint16_t                          *name;
> +    uint32_t                          name_size;
> +    uint32_t                          hashmarks;
> +    QTAILQ_ENTRY(uefi_var_policy)     next;
> +};

- I wonder if the size fields should be size_t. uint32_t is not wrong
either; we'll just have to be careful when doing comparisons etc.

- care to explain (in a comment) hashmarks? I think it's related to the
wildcard policy stuff, but a hint would be appreciated.

> +
> +struct uefi_vars_state {
> +    MemoryRegion                      mr;
> +    uint16_t                          sts;
> +    uint32_t                          buf_size;
> +    uint32_t                          buf_addr_lo;
> +    uint32_t                          buf_addr_hi;

spelling out endianness here would be useful IMO

> +    uint8_t                           *buffer;
> +    QTAILQ_HEAD(, uefi_variable)      variables;
> +    QTAILQ_HEAD(, uefi_var_policy)    var_policies;
> +
> +    /* boot phases */
> +    bool                              end_of_dxe;
> +    bool                              ready_to_boot;
> +    bool                              exit_boot_service;

There are some variations of the 8 possible that don't make sense. at
the same time, a single enum could be too limiting. depends on what the
code will do with these.

> +    bool                              policy_locked;
> +
> +    /* storage accounting */
> +    uint64_t                          max_storage;
> +    uint64_t                          used_storage;
> +
> +    char                              *jsonfile;
> +    int                               jsonfd;
> +};
> +
> +/* vars-service-guid.c */
> +extern QemuUUID EfiGlobalVariable;
> +extern QemuUUID EfiImageSecurityDatabase;
> +extern QemuUUID EfiCustomModeEnable;
> +extern QemuUUID EfiSecureBootEnableDisable;
> +extern QemuUUID EfiSmmVariableProtocolGuid;
> +extern QemuUUID VarCheckPolicyLibMmiHandlerGuid;
> +extern QemuUUID EfiEndOfDxeEventGroupGuid;
> +extern QemuUUID EfiEventReadyToBootGuid;
> +extern QemuUUID EfiEventExitBootServicesGuid;

the spelling of these names appears a bit questionable:

- camelcase is idiomatic in edk2, but (I think?) not in QEMU, for variables

- the "Guid" suffix is inconsistently used / carried over from edk2

> +
> +/* vars-service-core.c */
> +extern const VMStateDescription vmstate_uefi_vars;
> +size_t uefi_strlen(const uint16_t *str, size_t len);
> +gboolean uefi_str_equal(const uint16_t *a, size_t alen,
> +                        const uint16_t *b, size_t blen);
> +char *uefi_ucs2_to_ascii(const uint16_t *ucs2, uint64_t ucs2_size);
> +void uefi_trace_variable(const char *action, QemuUUID guid,
> +                         const uint16_t *name, uint64_t name_size);
> +void uefi_trace_status(const char *action, efi_status status);
> +void uefi_vars_init(Object *obj, uefi_vars_state *uv);
> +void uefi_vars_realize(uefi_vars_state *uv, Error **errp);
> +void uefi_vars_hard_reset(uefi_vars_state *uv);
> +
> +/* vars-service-json.c */
> +void uefi_vars_json_init(uefi_vars_state *uv, Error **errp);
> +void uefi_vars_json_save(uefi_vars_state *uv);
> +void uefi_vars_json_load(uefi_vars_state *uv, Error **errp);
> +
> +/* vars-service-vars.c */
> +extern const VMStateDescription vmstate_uefi_variable;
> +uefi_variable *uefi_vars_find_variable(uefi_vars_state *uv, QemuUUID guid,
> +                                       const uint16_t *name,
> +                                       uint64_t name_size);
> +void uefi_vars_set_variable(uefi_vars_state *uv, QemuUUID guid,
> +                            const uint16_t *name, uint64_t name_size,
> +                            uint32_t attributes,
> +                            void *data, uint64_t data_size);
> +void uefi_vars_clear_volatile(uefi_vars_state *uv);
> +void uefi_vars_clear_all(uefi_vars_state *uv);
> +void uefi_vars_update_storage(uefi_vars_state *uv);
> +uint32_t uefi_vars_mm_vars_proto(uefi_vars_state *uv);
> +
> +/* vars-service-auth.c */
> +void uefi_vars_auth_init(uefi_vars_state *uv);
> +
> +/* vars-service-policy.c */
> +extern const VMStateDescription vmstate_uefi_var_policy;
> +efi_status uefi_vars_policy_check(uefi_vars_state *uv,
> +                                  uefi_variable *var,
> +                                  gboolean is_newvar);
> +void uefi_vars_policies_clear(uefi_vars_state *uv);
> +uefi_var_policy *uefi_vars_add_policy(uefi_vars_state *uv,
> +                                      variable_policy_entry *pe);
> +uint32_t uefi_vars_mm_check_policy_proto(uefi_vars_state *uv);
> +
> +#endif /* QEMU_UEFI_VAR_SERVICE_H */

I guess I'll have to see these in use to think anything of them.

(I prefer a more "functional" structuring for a series, where the thing
sort of builds & works from patch#1 onwards, it's only the actual
functionality that is introduced layer by layer. But, that's not an
objection; this patch certainly works as the collection of APIs the rest
is going to implement and call later.)

Again we'll have to keep an eye on the integer types.

with some comments inserted:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


Laszlo



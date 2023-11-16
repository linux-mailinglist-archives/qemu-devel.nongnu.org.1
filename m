Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B5C7EE427
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:25:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3eDb-0002LE-39; Thu, 16 Nov 2023 10:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r3eDY-0002Jv-7m
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r3eDU-0003W0-EY
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700148219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMFovMmAZzuE9DyDNWbNcGOU9+nIkR+RL3127aCRJ1g=;
 b=VkZ++OU6r1eqPNW417CeTtrRkTZ2IN6BS2+6MQcsVDLgfFKocQQywUwkGlNAt3KEaIY+Lh
 vFNlEPpXSNyCtXQN2myjwUlkYU8j90CLsbU+w2sIOsL1QLfr6iNaYIEY85hltbbV26V4TY
 ++EtC4y6Ksdkt4+c8ZlFiWsdxQE4rqE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-40x4p16VOx6cXvHD0A6-CA-1; Thu, 16 Nov 2023 10:23:36 -0500
X-MC-Unique: 40x4p16VOx6cXvHD0A6-CA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6787F101A54C;
 Thu, 16 Nov 2023 15:23:35 +0000 (UTC)
Received: from [10.39.193.151] (unknown [10.39.193.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53AA11C060AE;
 Thu, 16 Nov 2023 15:23:33 +0000 (UTC)
Message-ID: <177badae-dcde-947e-0a28-03b6dfb2f55d@redhat.com>
Date: Thu, 16 Nov 2023 16:23:32 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 02/16] hw/uefi: add include/hw/uefi/var-service-edk2.h
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
 <20231115151242.184645-3-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231115151242.184645-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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
> A bunch of #defines and structs copied over from edk2,
> mostly needed to decode and encode the messages in the
> communication buffer.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/uefi/var-service-edk2.h | 184 +++++++++++++++++++++++++++++
>  1 file changed, 184 insertions(+)
>  create mode 100644 include/hw/uefi/var-service-edk2.h
> 
> diff --git a/include/hw/uefi/var-service-edk2.h b/include/hw/uefi/var-service-edk2.h
> new file mode 100644
> index 000000000000..354b74d1d71c
> --- /dev/null
> +++ b/include/hw/uefi/var-service-edk2.h
> @@ -0,0 +1,184 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * uefi-vars device - structs and defines from edk2
> + *
> + * Note: The edk2 UINTN type has been mapped to uint64_t,
> + *       so the structs are compatible with 64bit edk2 builds.

(1) What is the failure mode if the guest runs a 32-bit DXE phase and
tries to access this device?

> + */
> +#ifndef QEMU_UEFI_VAR_SERVICE_EDK2_H
> +#define QEMU_UEFI_VAR_SERVICE_EDK2_H
> +
> +#include "qemu/uuid.h"
> +
> +#define MAX_BIT                   0x8000000000000000ULL
> +#define ENCODE_ERROR(StatusCode)  (MAX_BIT | (StatusCode))
> +#define EFI_SUCCESS               0

(2) Probably better to make this 0ULL, so that its type is consistent
with that of the error codes.

(3) BTW, these error codes are not edk2-specific; they are from the UEFI
spec (Appendix D, "Status Codes"). I'm mentioning it because it might
clarify the commit message.

> +#define EFI_INVALID_PARAMETER     ENCODE_ERROR(2)
> +#define EFI_UNSUPPORTED           ENCODE_ERROR(3)
> +#define EFI_BAD_BUFFER_SIZE       ENCODE_ERROR(4)
> +#define EFI_BUFFER_TOO_SMALL      ENCODE_ERROR(5)

(4) any particular reason for skipping NOT_READY (6) and DEVICE_ERROR (7)?

(If this file only defines status codes that the code actually uses,
that's best!)

> +#define EFI_WRITE_PROTECTED       ENCODE_ERROR(8)
> +#define EFI_OUT_OF_RESOURCES      ENCODE_ERROR(9)
> +#define EFI_NOT_FOUND             ENCODE_ERROR(14)
> +#define EFI_ACCESS_DENIED         ENCODE_ERROR(15)
> +#define EFI_ALREADY_STARTED       ENCODE_ERROR(20)
> +
> +#define EFI_VARIABLE_NON_VOLATILE                           0x01
> +#define EFI_VARIABLE_BOOTSERVICE_ACCESS                     0x02
> +#define EFI_VARIABLE_RUNTIME_ACCESS                         0x04
> +#define EFI_VARIABLE_HARDWARE_ERROR_RECORD                  0x08
> +#define EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS             0x10  // deprecated
> +#define EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS  0x20
> +#define EFI_VARIABLE_APPEND_WRITE                           0x40
> +
> +/* SecureBootEnable */

(5) L"SecureBootEnable"

(6) mentioning the variable namespace GUID might be worthwhile as well
(gEfiSecureBootEnableDisableGuid -- F0A30BC7-AF08-4556-99C4-001009C93A44)

(7) this variable is an edk2 extension indeed; might be worth mentioning

> +#define SECURE_BOOT_ENABLE         1
> +#define SECURE_BOOT_DISABLE        0
> +
> +/* SecureBoot */

(8) L"SecureBoot"

(9) this one is standard, so the namespace GUID is not important to
mention -- but maybe mention that it is standard

> +#define SECURE_BOOT_MODE_ENABLE    1
> +#define SECURE_BOOT_MODE_DISABLE   0
> +
> +/* CustomMode */

the usual comments:

(10) L"CustomMode"

(11) GUID: gEfiCustomModeEnableGuid -- C076EC0C-7028-4399-A072-71EE5C448B9F

(12) edk2 extension

> +#define CUSTOM_SECURE_BOOT_MODE    1
> +#define STANDARD_SECURE_BOOT_MODE  0
> +
> +/* SetupMode */

(13) L"SetupMode"

(14) standard

> +#define SETUP_MODE                 1
> +#define USER_MODE                  0
> +
> +typedef uint64_t efi_status;
> +typedef struct mm_header mm_header;
> +
> +/* EFI_MM_COMMUNICATE_HEADER */
> +struct mm_header {
> +    QemuUUID  guid;
> +    uint64_t  length;
> +};

(15) QEMU_PACKED

> +
> +/* --- EfiSmmVariableProtocol ---------------------------------------- */

(16) this is a bit too cryptic like this; what we mean here is that
mm_header.guid is gEfiSmmVariableProtocolGuid
(ED32D533-99E6-4209-9CC0-2D72CDD998A7) for the following functions

(17) do you want to define SMM_VARIABLE_COMMUNICATE_HEADER as well?
(because the function codes make sense inside that header) -- ah wait,
those are below; OK

(18) slight inconsistency: the function macros are named SMM_*, but the
types are named mm_*.

However... that inconsistency seems to be there in edk2 to as well; we
don't have (for example) "MM_VARIABLE_FUNCTION_GET_VARIABLE"

> +
> +#define SMM_VARIABLE_FUNCTION_GET_VARIABLE            1
> +#define SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME  2
> +#define SMM_VARIABLE_FUNCTION_SET_VARIABLE            3
> +#define SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO     4
> +#define SMM_VARIABLE_FUNCTION_READY_TO_BOOT           5
> +#define SMM_VARIABLE_FUNCTION_EXIT_BOOT_SERVICE       6
> +#define SMM_VARIABLE_FUNCTION_LOCK_VARIABLE           8
> +#define SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE       11
> +
> +typedef struct mm_variable mm_variable;
> +typedef struct mm_variable_access mm_variable_access;
> +typedef struct mm_next_variable mm_next_variable;
> +typedef struct mm_next_variable mm_lock_variable;
> +typedef struct mm_variable_info mm_variable_info;
> +typedef struct mm_get_payload_size mm_get_payload_size;
> +
> +/* SMM_VARIABLE_COMMUNICATE_HEADER */
> +struct mm_variable {
> +    uint64_t  function;
> +    uint64_t  status;
> +};

(19) you have a typedef for efi_status above; no need to decode it to
uint64_t here (for the status field)

(20) This too should be QEMU_PACKED. (Will not make a difference in
practice, but this is wire protocol, so best be clear.)

BTW I'm just noticing that SMM_VARIABLE_COMMUNICATE_HEADER in edk2's
"MdeModulePkg/Include/Guid/SmmVariableCommon.h" is *not* marked packed.
That's a bug in edk2, of course (documentation bug).

(21) a comment about the general request structure would be helpful:
mm_header + mm_variable + function payload (any).

> +
> +/* SMM_VARIABLE_COMMUNICATE_ACCESS_VARIABLE */

(22) worth mentioning functions 1 and 3?

> +struct QEMU_PACKED mm_variable_access {

I can see you packed this! :)

> +    QemuUUID  guid;
> +    uint64_t  data_size;

correct, but we'll have to be careful with the range checks / buffer
size checks later, because UEFI_VARS_REG_BUFFER_SIZE is only 32-bit!

> +    uint64_t  name_size;
> +    uint32_t  attributes;
> +    /* Name */
> +    /* Data */
> +};
> +
> +/* SMM_VARIABLE_COMMUNICATE_GET_NEXT_VARIABLE_NAME */

(23) worth mentioning function 2, or is that obvious from the name?

> +struct mm_next_variable {
> +    QemuUUID  guid;
> +    uint64_t  name_size;
> +    /* Name */
> +};

(24) should be packed

> +
> +/* SMM_VARIABLE_COMMUNICATE_QUERY_VARIABLE_INFO */
> +struct QEMU_PACKED mm_variable_info {
> +    uint64_t max_storage_size;
> +    uint64_t free_storage_size;
> +    uint64_t max_variable_size;
> +    uint32_t attributes;
> +};

(25) mention function 4?

> +
> +/* SMM_VARIABLE_COMMUNICATE_GET_PAYLOAD_SIZE */

(26) mention function 11?

> +struct mm_get_payload_size {
> +    uint64_t  payload_size;
> +};

(27) should be packed (just for documentation / exluding trailing padding)

> +
> +/* --- VarCheckPolicyLibMmiHandler ----------------------------------- */

(28) Please be clearer: this means that we place GUID
DA1B0D11-D1A7-46C4-9DC9-F3714875C6EB into mm_header.guid.

(29) Also record that the generic structure is mm_header +
mm_check_policy + command payload (if any).

> +
> +#define VAR_CHECK_POLICY_COMMAND_DISABLE     0x01
> +#define VAR_CHECK_POLICY_COMMAND_IS_ENABLED  0x02
> +#define VAR_CHECK_POLICY_COMMAND_REGISTER    0x03
> +#define VAR_CHECK_POLICY_COMMAND_DUMP        0x04
> +#define VAR_CHECK_POLICY_COMMAND_LOCK        0x05
> +
> +typedef struct mm_check_policy mm_check_policy;
> +typedef struct mm_check_policy_is_enabled mm_check_policy_is_enabled;
> +typedef struct mm_check_policy_dump_params mm_check_policy_dump_params;
> +
> +/* VAR_CHECK_POLICY_COMM_HEADER */
> +struct QEMU_PACKED mm_check_policy {
> +    uint32_t  signature;
> +    uint32_t  revision;
> +    uint32_t  command;
> +    uint64_t  result;

(30) field "result" should have "efi_status"

(31) define the macros for (a) signature (VCPC) and (b) revision (1)?

> +};
> +
> +/* VAR_CHECK_POLICY_COMM_IS_ENABLED_PARAMS */

(32) mention command 2? (Just guessing)

> +struct QEMU_PACKED mm_check_policy_is_enabled {
> +    uint8_t   state;
> +};

(33) given that this is a "BOOLEAN" in the original, we might want to
introduce a typedef "edk2_boolean" for uint8_t. Just an idea.

> +
> +/* VAR_CHECK_POLICY_COMM_DUMP_PARAMS */

(34) mention command 4?

> +struct QEMU_PACKED mm_check_policy_dump_params {
> +    uint32_t  page_requested;
> +    uint32_t  total_size;
> +    uint32_t  page_size;
> +    uint8_t   has_more;

(35) consider updating the last field's type to "edk2_boolean".

> +};
> +
> +/* --- Edk2VariablePolicyProtocol ------------------------------------ */

(36) the proper spelling is "EdkiiVariablePolicyProtocol" (note: roman
numeral "ii" rather than arabic numeral 2)

(37) Mentioning this protocol here is confusing, IMO. Please correct me
if I'm wrong, but the protocol appears to be used between DXE
components, and not on the DXE<->SMM boundary.

Instead, we need the following ABIs as payloads for
VAR_CHECK_POLICY_COMMAND_REGISTER.

Therefore I would remove the EdkiiVariablePolicyProtocol mention above
altogether, and instead clarify that these are for:

- mm_header + mm_check_policy (command 3) + variable_policy_entry,
  or

- mm_header + mm_check_policy (command 3) +
  variable_policy_entry (policy 3) + variable_lock_on_var_state

> +
> +#define VARIABLE_POLICY_ENTRY_REVISION  0x00010000
> +
> +#define VARIABLE_POLICY_TYPE_NO_LOCK            0
> +#define VARIABLE_POLICY_TYPE_LOCK_NOW           1
> +#define VARIABLE_POLICY_TYPE_LOCK_ON_CREATE     2
> +#define VARIABLE_POLICY_TYPE_LOCK_ON_VAR_STATE  3
> +
> +typedef struct variable_policy_entry variable_policy_entry;
> +typedef struct variable_lock_on_var_state variable_lock_on_var_state;
> +
> +/* VARIABLE_POLICY_ENTRY */
> +struct variable_policy_entry {

(38) should be packed

> +    uint32_t      version;
> +    uint16_t      size;
> +    uint16_t      offset_to_name;
> +    QemuUUID      namespace;
> +    uint32_t      min_size;
> +    uint32_t      max_size;

(39) also define the macros for "no min size" and "no max size"?

> +    uint32_t      attributes_must_have;
> +    uint32_t      attributes_cant_have;

(40) define the macros that invalidate these fields?

> +    uint8_t       lock_policy_type;
> +    uint8_t       padding[3];
> +    /* LockPolicy */
> +    /* Name */
> +};
> +
> +/* VARIABLE_LOCK_ON_VAR_STATE_POLICY */
> +struct variable_lock_on_var_state {

(41) should be packed

> +    QemuUUID      namespace;
> +    uint8_t       value;
> +    uint8_t       padding;
> +    /* Name */

(42) probably worth mentioning the link

https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/VariablePolicyLib/ReadMe.md

around these parts too, not just in patch 8.

> +};
> +
> +
> +#endif /* QEMU_UEFI_VAR_SERVICE_EDK2_H */

Laszlo



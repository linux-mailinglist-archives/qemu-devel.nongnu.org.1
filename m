Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF8709022
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 09:07:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzuCe-0007aK-I4; Fri, 19 May 2023 03:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzuCZ-0007a8-CF
 for qemu-devel@nongnu.org; Fri, 19 May 2023 03:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzuCX-0005p7-HN
 for qemu-devel@nongnu.org; Fri, 19 May 2023 03:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684480016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5FdsItepC27DvKw/JY3lcPwStXuHJdWIiCDjVQyvPc=;
 b=CfcdUjCc9WnNUEdc/r8Gg9xIpTZ+m8W45V+tAUCE8uS3CoYoSzYYll3bZEb+56y9fNqGFZ
 vtcsL8PiKJPYMtyiopbSF30XHNtx4ypH11vHda4BGL1ld4j++953EyWWSSQ3oeaF661YWA
 G08pX9XTgL+1Z2a1fLG3tW/pl+NkbmY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-Q7bZq3FpPjKnQEFKvOchYg-1; Fri, 19 May 2023 03:06:54 -0400
X-MC-Unique: Q7bZq3FpPjKnQEFKvOchYg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2af17f626e3so8817871fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 00:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684480013; x=1687072013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5FdsItepC27DvKw/JY3lcPwStXuHJdWIiCDjVQyvPc=;
 b=HgpGIkTdIZdpLqhrGpne7GG6tOxCYFhe8uI1lpgS6Cv5nyiUs9EzTV4Mev44c9F7GR
 GMUpLOI3PcTWZZDgnsZ59j4a5NzK2GG1B1rAqPvXuTc0Xhgu8cA3g9fOyW8nhfWk+Zms
 eOO5dvBVH8ljBIK/D5R7XeQZ97gZiyN2nWqEguAFFxiCTKRH8XnHLeCNOnIcQ2CchISn
 RcxMw2/yq8A4EMOpXnC165MtUJtuESc1qOPpIAeZhpBjdvECNdDgV/DgYUfMkUuWH4VR
 aNISSYQrYg8edgfMNv+MUz6NXJGcCKCLX3bSSOmztxnYB5vxdbGKbbvFF/Ldi3FmnnI2
 tIPQ==
X-Gm-Message-State: AC+VfDwK0GQVXyYaHsYu7H7+o53Yc0bIJdv5aU+fdgwFfYrqKNooH4yb
 T3VyROVX/JZlEv8aSwr0rBrNLtjax5jeqjpPWKscAHI45VHjOiYRoJoqix0n51botKxbopN4ktp
 s6UpHciIYxXYx1qk=
X-Received: by 2002:a2e:7811:0:b0:2a8:b286:8272 with SMTP id
 t17-20020a2e7811000000b002a8b2868272mr349379ljc.15.1684480012930; 
 Fri, 19 May 2023 00:06:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6uxoRR2avyHDTi2wTl9MTw/gjbdAoG3DVIdaZMqS4ffvv2TFkzyfMC06Lq9bXomScyOt1+tg==
X-Received: by 2002:a2e:7811:0:b0:2a8:b286:8272 with SMTP id
 t17-20020a2e7811000000b002a8b2868272mr349365ljc.15.1684480012559; 
 Fri, 19 May 2023 00:06:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a2e9802000000b002af0464353bsm653570ljj.106.2023.05.19.00.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 00:06:51 -0700 (PDT)
Date: Fri, 19 May 2023 03:06:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 7/7] hw/cxl/events: Add injection of Memory Module
 Events
Message-ID: <20230519030626-mutt-send-email-mst@kernel.org>
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
 <20230423165140.16833-8-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423165140.16833-8-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Apr 23, 2023 at 05:51:40PM +0100, Jonathan Cameron wrote:
> These events include a copy of the device health information at the
> time of the event. Actually using the emulated device health would
> require a lot of controls to manipulate that state.  Given the aim
> of this injection code is to just test the flows when events occur,
> inject the contents of the device health state as well.
> 
> Future work may add more sophisticate device health emulation
> including direct generation of these records when events occur
> (such as a temperature threshold being crossed).  That does not
> reduce the usefulness of this more basic generation of the events.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --

This should be --- not --, otherwise git am does not cut at this point.


> v5:
> * Rebase
> * Update Since entries for QMP.
> ---
>  hw/mem/cxl_type3.c          | 62 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    | 12 +++++++
>  include/hw/cxl/cxl_events.h | 19 ++++++++++++
>  qapi/cxl.json               | 35 +++++++++++++++++++++
>  4 files changed, 128 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 71df31917c..5d1b3a5b9b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1201,6 +1201,11 @@ static const QemuUUID dram_uuid = {
>                   0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
>  };
>  
> +static const QemuUUID memory_module_uuid = {
> +    .data = UUID(0xfe927475, 0xdd59, 0x4339, 0xa5, 0x86,
> +                 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
> +};
> +
>  #define CXL_GMER_VALID_CHANNEL                          BIT(0)
>  #define CXL_GMER_VALID_RANK                             BIT(1)
>  #define CXL_GMER_VALID_DEVICE                           BIT(2)
> @@ -1408,6 +1413,63 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>      return;
>  }
>  
> +void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> +                                        uint8_t flags, uint8_t type,
> +                                        uint8_t health_status,
> +                                        uint8_t media_status,
> +                                        uint8_t additional_status,
> +                                        uint8_t life_used,
> +                                        int16_t temperature,
> +                                        uint32_t dirty_shutdown_count,
> +                                        uint32_t corrected_volatile_error_count,
> +                                        uint32_t corrected_persistent_error_count,
> +                                        Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLEventMemoryModule module;
> +    CXLEventRecordHdr *hdr = &module.hdr;
> +    CXLDeviceState *cxlds;
> +    CXLType3Dev *ct3d;
> +    uint8_t enc_log;
> +    int rc;
> +
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +    ct3d = CXL_TYPE3(obj);
> +    cxlds = &ct3d->cxl_dstate;
> +
> +    rc = ct3d_qmp_cxl_event_log_enc(log);
> +    if (rc < 0) {
> +        error_setg(errp, "Unhandled error log type");
> +        return;
> +    }
> +    enc_log = rc;
> +
> +    memset(&module, 0, sizeof(module));
> +    cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +
> +    module.type = type;
> +    module.health_status = health_status;
> +    module.media_status = media_status;
> +    module.additional_status = additional_status;
> +    module.life_used = life_used;
> +    stw_le_p(&module.temperature, temperature);
> +    stl_le_p(&module.dirty_shutdown_count, dirty_shutdown_count);
> +    stl_le_p(&module.corrected_volatile_error_count, corrected_volatile_error_count);
> +    stl_le_p(&module.corrected_persistent_error_count, corrected_persistent_error_count);
> +
> +    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 235c171264..2196bd841c 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -26,6 +26,18 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>                                 bool has_correction_mask, uint64List *correction_mask,
>                                 Error **errp) {}
>  
> +void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> +                                        uint8_t flags, uint8_t type,
> +                                        uint8_t health_status,
> +                                        uint8_t media_status,
> +                                        uint8_t additional_status,
> +                                        uint8_t life_used,
> +                                        int16_t temperature,
> +                                        uint32_t dirty_shutdown_count,
> +                                        uint32_t corrected_volatile_error_count,
> +                                        uint32_t corrected_persistent_error_count,
> +                                        Error **errp) {}
> +
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>                             Error **errp)
>  {
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index a39e30d973..089ba2091f 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -146,4 +146,23 @@ typedef struct CXLEventDram {
>      uint8_t reserved[0x17];
>  } QEMU_PACKED CXLEventDram;
>  
> +/*
> + * Memory Module Event Record
> + * CXL Rev 3.0 Section 8.2.9.2.1.3: Table 8-45
> + * All fields little endian.
> + */
> +typedef struct CXLEventMemoryModule {
> +    CXLEventRecordHdr hdr;
> +    uint8_t type;
> +    uint8_t health_status;
> +    uint8_t media_status;
> +    uint8_t additional_status;
> +    uint8_t life_used;
> +    int16_t temperature;
> +    uint32_t dirty_shutdown_count;
> +    uint32_t corrected_volatile_error_count;
> +    uint32_t corrected_persistent_error_count;
> +    uint8_t reserved[0x3d];
> +} QEMU_PACKED CXLEventMemoryModule;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 190db58385..aae70667c2 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -90,6 +90,41 @@
>              '*column': 'uint16', '*correction-mask': [ 'uint64' ]
>             }}
>  
> +##
> +# @cxl-inject-memory-module-event:
> +#
> +# Inject an event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3)
> +# This event includes a copy of the Device Health info at the time of
> +# the event.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +# @log: Event Log to add the event to
> +# @flags: header flags
> +# @type: Device Event Type (see spec for permitted values)
> +# @health-status: Overall health summary bitmap (see spec for permitted bits)
> +# @media-status: Overall media health summary (see spec for permitted values)
> +# @additional-status: Complex field (see spec for meaning)
> +# @life-used: Percentage (0-100) of factory expected life span
> +# @temperature: Device temperature in degrees Celsius
> +# @dirty-shutdown-count: Counter incremented whenever device is unable
> +#                        to determine if data loss may have occurred.
> +# @corrected-volatile-error-count: Total number of correctable errors in
> +#                                  volatile memory
> +# @corrected-persistent-error-count: Total number correctable errors in
> +#                                    persistent memory
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-memory-module-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> +            'type': 'uint8', 'health-status': 'uint8',
> +            'media-status': 'uint8', 'additional-status': 'uint8',
> +            'life-used': 'uint8', 'temperature' : 'int16',
> +            'dirty-shutdown-count': 'uint32',
> +            'corrected-volatile-error-count': 'uint32',
> +            'corrected-persistent-error-count': 'uint32'
> +            }}
> +
>  ##
>  # @cxl-inject-poison:
>  #
> -- 
> 2.37.2



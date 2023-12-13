Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 496FC8114E1
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 15:40:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQOO-000242-1z; Wed, 13 Dec 2023 09:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rDQOM-00023T-5H; Wed, 13 Dec 2023 09:39:18 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rDQOJ-0005g5-3M; Wed, 13 Dec 2023 09:39:17 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6d9da137748so3022318a34.1; 
 Wed, 13 Dec 2023 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702478352; x=1703083152; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=RSb5+RPGDNTDhxBpJ87v1J7pNhMcviDdCPYIOP6wgK4=;
 b=cLaFo/O1HWfMxkl4GlZI30cTEhiRBE3ZSXVEphjnu8SUDf1WwbIk91W3X822k/+Ssp
 XEs26sTnwkGIi6SHM+xeFUqwDD6NDdFtQrw0Mmn3tPiiOxMSS4e1SoukLM2PzznyNEvr
 IBkH1NvhzvdvwKyjJ6pJerp5pkPjDXXjmoh7FEDuBCgTwWgnI4sVn+yvMdpcWoTzw84o
 fhxyZYT2BCuw8NshqE+h+z7pde8mu8ciYIuoO69yEBLPcB+eUMNXXuU9WgOpCuKwiSsM
 uKoEEcHGj/3ujOtskGy+8pg+NwLYaj0uEm5UNkw3Mwzmm8xG53XDPx1AJPaetkjo4ZoS
 5K2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702478352; x=1703083152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSb5+RPGDNTDhxBpJ87v1J7pNhMcviDdCPYIOP6wgK4=;
 b=RD8edSHJL9flpjKmhCMUC+XYzp5FhoYRRzY3l2iLxGr+7uf6Ku8M9Seb8/TzvKkxY1
 NdVTBgYdBvSRotHMiaa2+WY2/lKZv1+Kqz5+ENV5uHeh4KM+vycQ1nB82i3FAYwFcTk6
 7EP5J85Zpsi9ny3Rm7tHgN9AkrC2IyG60Y530pR4Re7Qjmtm5drbyxGFVjaUTXbXeAgw
 lEjGo6LHD/fGycAuCIR2Ft3pZo/NfCtqyO1520bMe0WTKuc9juoef7TNzrRfQSW7LujK
 Iik+ryPOiSBQn9fxrZDEqjYgyYlgogoglztp2RHNpZX7ZHboos9QMTEzzOJvTeJlQKvz
 pSEA==
X-Gm-Message-State: AOJu0YyM1oepHd70hnvVJCYZPV0g/e5Ri1JLe2wSSfIdvM8syheBEItR
 kOZHIjCEh+LaBabUnrrszcI=
X-Google-Smtp-Source: AGHT+IEdqJIty45aOHcUcVXW0vMGnjzj/JqhbEMeyf7JjGD5p+/v1Lso00Jk27dLZA3n61MKxq8KWA==
X-Received: by 2002:a05:6830:1d44:b0:6d8:1a5a:c8c1 with SMTP id
 p4-20020a0568301d4400b006d81a5ac8c1mr3263535oth.10.1702478351744; 
 Wed, 13 Dec 2023 06:39:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 ck10-20020a056830648a00b006d9b1bbc666sm1713013otb.17.2023.12.13.06.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 06:39:11 -0800 (PST)
Date: Wed, 13 Dec 2023 06:39:10 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Iris Chen <irischenlj@gmail.com>
Cc: irischenlj@fb.com, peter@pjd.dev, pdel@fb.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, clg@kaod.org, patrick@stwcx.xyz,
 alistair@alistair23.me, kwolf@redhat.com, hreitz@redhat.com,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, dz4list@gmail.com
Subject: Re: [RFC 1/1] hw: tpmtisspi: add SPI support to QEMU TPM
 implementation
Message-ID: <f3b384d6-10c7-42c7-aedb-1c4504e45085@roeck-us.net>
References: <20220803023241.63739-1-irischenlj@gmail.com>
 <20220803023241.63739-2-irischenlj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803023241.63739-2-irischenlj@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=groeck7@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Aug 02, 2022 at 07:32:41PM -0700, Iris Chen wrote:
> From: Iris Chen <irischenlj@fb.com>
> 
> Signed-off-by: Iris Chen <irischenlj@fb.com>
> ---

Are there any plans to submit a new version of this patch ?

Thanks,
Guenter

>  configs/devices/arm-softmmu/default.mak |   1 +
>  hw/arm/Kconfig                          |   5 +
>  hw/tpm/Kconfig                          |   5 +
>  hw/tpm/meson.build                      |   1 +
>  hw/tpm/tpm_tis_spi.c                    | 311 ++++++++++++++++++++++++
>  include/sysemu/tpm.h                    |   3 +
>  6 files changed, 326 insertions(+)
>  create mode 100644 hw/tpm/tpm_tis_spi.c
> 
> diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
> index 6985a25377..80d2841568 100644
> --- a/configs/devices/arm-softmmu/default.mak
> +++ b/configs/devices/arm-softmmu/default.mak
> @@ -42,3 +42,4 @@ CONFIG_FSL_IMX6UL=y
>  CONFIG_SEMIHOSTING=y
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
>  CONFIG_ALLWINNER_H3=y
> +CONFIG_FBOBMC_AST=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 15fa79afd3..193decaec1 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -458,6 +458,11 @@ config ASPEED_SOC
>      select PMBUS
>      select MAX31785
>  
> +config FBOBMC_AST
> +    bool
> +    select ASPEED_SOC
> +    select TPM_TIS_SPI
> +
>  config MPS2
>      bool
>      imply I2C_DEVICES
> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> index 29e82f3c92..370a43f045 100644
> --- a/hw/tpm/Kconfig
> +++ b/hw/tpm/Kconfig
> @@ -8,6 +8,11 @@ config TPM_TIS_SYSBUS
>      depends on TPM
>      select TPM_TIS
>  
> +config TPM_TIS_SPI
> +    bool
> +    depends on TPM
> +    select TPM_TIS
> +
>  config TPM_TIS
>      bool
>      depends on TPM
> diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
> index 1c68d81d6a..1a057f4e36 100644
> --- a/hw/tpm/meson.build
> +++ b/hw/tpm/meson.build
> @@ -2,6 +2,7 @@ softmmu_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_tis_common.c'))
>  softmmu_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: files('tpm_tis_isa.c'))
>  softmmu_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm_tis_sysbus.c'))
>  softmmu_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
> +softmmu_ss.add(when: 'CONFIG_TPM_TIS_SPI', if_true: files('tpm_tis_spi.c'))
>  
>  specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPM_TIS'], if_true: files('tpm_ppi.c'))
>  specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPM_CRB'], if_true: files('tpm_ppi.c'))
> diff --git a/hw/tpm/tpm_tis_spi.c b/hw/tpm/tpm_tis_spi.c
> new file mode 100644
> index 0000000000..c98ddcfddb
> --- /dev/null
> +++ b/hw/tpm/tpm_tis_spi.c
> @@ -0,0 +1,311 @@
> +#include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "hw/acpi/tpm.h"
> +#include "tpm_prop.h"
> +#include "tpm_tis.h"
> +#include "qom/object.h"
> +#include "hw/ssi/ssi.h"
> +#include "hw/ssi/spi_gpio.h"
> +
> +#define TPM_TIS_SPI_ADDR_BYTES 3
> +#define SPI_WRITE 0
> +
> +typedef enum {
> +    TIS_SPI_PKT_STATE_DEACTIVATED = 0,
> +    TIS_SPI_PKT_STATE_START,
> +    TIS_SPI_PKT_STATE_ADDRESS,
> +    TIS_SPI_PKT_STATE_DATA_WR,
> +    TIS_SPI_PKT_STATE_DATA_RD,
> +    TIS_SPI_PKT_STATE_DONE,
> +} TpmTisSpiPktState;
> +
> +union TpmTisRWSizeByte {
> +    uint8_t byte;
> +    struct {
> +        uint8_t data_expected_size:6;
> +        uint8_t resv:1;
> +        uint8_t rwflag:1;
> +    };
> +};
> +
> +union TpmTisSpiHwAddr {
> +    hwaddr addr;
> +    uint8_t bytes[sizeof(hwaddr)];
> +};
> +
> +union TpmTisSpiData {
> +    uint32_t data;
> +    uint8_t bytes[64];
> +};
> +
> +struct TpmTisSpiState {
> +    /*< private >*/
> +    SSIPeripheral parent_obj;
> +
> +    /*< public >*/
> +    TPMState tpm_state; /* not a QOM object */
> +    TpmTisSpiPktState tpm_tis_spi_state;
> +
> +    union TpmTisRWSizeByte first_byte;
> +    union TpmTisSpiHwAddr addr;
> +    union TpmTisSpiData data;
> +
> +    uint32_t data_size;
> +    uint8_t data_idx;
> +    uint8_t addr_idx;
> +};
> +
> +struct TpmTisSpiClass {
> +    SSIPeripheralClass parent_class;
> +};
> +
> +OBJECT_DECLARE_TYPE(TpmTisSpiState, TpmTisSpiClass, TPM_TIS_SPI)
> +
> +static void tpm_tis_spi_mmio_read(TpmTisSpiState *tts)
> +{
> +    uint16_t offset = tts->addr.addr & 0xffc;
> +
> +    switch (offset) {
> +    case TPM_TIS_REG_DATA_FIFO:
> +        for (uint8_t i = 0; i < tts->data_size; i++) {
> +            tts->data.bytes[i] = (uint8_t)tpm_tis_memory_ops.read(
> +                                          &tts->tpm_state,
> +                                          tts->addr.addr,
> +                                          1);
> +        }
> +        break;
> +    default:
> +        tts->data.data = (uint32_t)tpm_tis_memory_ops.read(
> +                                   &tts->tpm_state,
> +                                   tts->addr.addr,
> +                                   tts->data_size);
> +    }
> +}
> +
> +static void tpm_tis_spi_mmio_write(TpmTisSpiState *tts)
> +{
> +    uint16_t offset = tts->addr.addr & 0xffc;
> +
> +    switch (offset) {
> +    case TPM_TIS_REG_DATA_FIFO:
> +        for (uint8_t i = 0; i < tts->data_size; i++) {
> +            tpm_tis_memory_ops.write(&tts->tpm_state,
> +                                     tts->addr.addr,
> +                                     tts->data.bytes[i],
> +                                     1);
> +        }
> +        break;
> +    default:
> +        tpm_tis_memory_ops.write(&tts->tpm_state,
> +                                 tts->addr.addr,
> +                                 tts->data.data,
> +                                 tts->data_size);
> +        }
> +}
> +
> +static uint32_t tpm_tis_spi_transfer8(SSIPeripheral *ss, uint32_t tx)
> +{
> +    TpmTisSpiState *tts = TPM_TIS_SPI(ss);
> +    uint32_t r = 1;
> +
> +    switch (tts->tpm_tis_spi_state) {
> +    case TIS_SPI_PKT_STATE_START:
> +        tts->first_byte.byte = (uint8_t)tx;
> +        tts->data_size = tts->first_byte.data_expected_size + 1;
> +        tts->data_idx = 0;
> +        tts->addr_idx = TPM_TIS_SPI_ADDR_BYTES;
> +        tts->tpm_tis_spi_state = TIS_SPI_PKT_STATE_ADDRESS;
> +        break;
> +    case TIS_SPI_PKT_STATE_ADDRESS:
> +        assert(tts->addr_idx > 0);
> +        tts->addr.bytes[--tts->addr_idx] = (uint8_t)tx;
> +
> +        if (tts->addr_idx == 0) {
> +            if (tts->first_byte.rwflag == SPI_WRITE) {
> +                tts->tpm_tis_spi_state = TIS_SPI_PKT_STATE_DATA_WR;
> +            } else { /* read and get the data ready */
> +                tpm_tis_spi_mmio_read(tts);
> +                tts->tpm_tis_spi_state = TIS_SPI_PKT_STATE_DATA_RD;
> +            }
> +        }
> +        break;
> +    case TIS_SPI_PKT_STATE_DATA_WR:
> +        tts->data.bytes[tts->data_idx++] = (uint8_t)tx;
> +        if (tts->data_idx == tts->data_size) {
> +            tpm_tis_spi_mmio_write(tts);
> +            tts->tpm_tis_spi_state = TIS_SPI_PKT_STATE_DONE;
> +        }
> +        break;
> +    case TIS_SPI_PKT_STATE_DATA_RD:
> +        r = tts->data.bytes[tts->data_idx++];
> +        if (tts->data_idx == tts->data_size) {
> +            tts->tpm_tis_spi_state = TIS_SPI_PKT_STATE_DONE;
> +        }
> +        break;
> +    default:
> +        tts->tpm_tis_spi_state = TIS_SPI_PKT_STATE_DEACTIVATED;
> +        r = (uint32_t) -1;
> +    }
> +
> +    return r;
> +}
> +
> +/*
> + * Pre-reading logic for transfer:
> + * This is to fix the transaction between reading and writing.
> + * The first byte is arbitrarily inserted so we need to
> + * shift the all the output bytes (timeline) one byte right.
> + */
> +static uint32_t tpm_tis_spi_transfer8_ex(SSIPeripheral *ss, uint32_t tx)
> +{
> +    TpmTisSpiState *tts = TPM_TIS_SPI(ss);
> +    SSIBus *ssibus = (SSIBus *)qdev_get_parent_bus(DEVICE(tts));
> +
> +    TpmTisSpiPktState prev_state = tts->tpm_tis_spi_state;
> +    uint32_t r = tpm_tis_spi_transfer8(ss, tx);
> +    TpmTisSpiPktState curr_state = tts->tpm_tis_spi_state;
> +
> +    if (ssibus->preread &&
> +       /* cmd state has changed into DATA reading state */
> +       prev_state != TIS_SPI_PKT_STATE_DATA_RD &&
> +       curr_state == TIS_SPI_PKT_STATE_DATA_RD) {
> +        r = tpm_tis_spi_transfer8(ss, 0xFF);
> +    }
> +
> +    return r;
> +}
> +
> +static int tpm_tis_spi_cs(SSIPeripheral *ss, bool select)
> +{
> +    TpmTisSpiState *tts = TPM_TIS_SPI(ss);
> +
> +    if (select) { /* cs de-assert */
> +        tts->tpm_tis_spi_state = TIS_SPI_PKT_STATE_DEACTIVATED;
> +    } else {
> +        tts->tpm_tis_spi_state = TIS_SPI_PKT_STATE_START;
> +        tts->first_byte.byte = 0;
> +        tts->addr.addr = 0;
> +        tts->data.data = 0;
> +    }
> +
> +    return 0;
> +}
> +
> +static int tpm_tis_pre_save_spi(void *opaque)
> +{
> +    TpmTisSpiState *sbdev = opaque;
> +
> +    return tpm_tis_pre_save(&sbdev->tpm_state);
> +}
> +
> +static const VMStateDescription vmstate_tpm_tis_spi = {
> +    .name = "tpm-tis-spi",
> +    .version_id = 0,
> +    .pre_save  = tpm_tis_pre_save_spi,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BUFFER(tpm_state.buffer, TpmTisSpiState),
> +        VMSTATE_UINT16(tpm_state.rw_offset, TpmTisSpiState),
> +        VMSTATE_UINT8(tpm_state.active_locty, TpmTisSpiState),
> +        VMSTATE_UINT8(tpm_state.aborting_locty, TpmTisSpiState),
> +        VMSTATE_UINT8(tpm_state.next_locty, TpmTisSpiState),
> +
> +        VMSTATE_STRUCT_ARRAY(tpm_state.loc, TpmTisSpiState, TPM_TIS_NUM_LOCALITIES,
> +                             0, vmstate_locty, TPMLocality),
> +
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void tpm_tis_spi_request_completed(TPMIf *ti, int ret)
> +{
> +    TpmTisSpiState *sbdev = TPM_TIS_SPI(ti);
> +    TPMState *s = &sbdev->tpm_state;
> +
> +    tpm_tis_request_completed(s, ret);
> +}
> +
> +static enum TPMVersion tpm_tis_spi_get_tpm_version(TPMIf *ti)
> +{
> +    TpmTisSpiState *sbdev = TPM_TIS_SPI(ti);
> +    TPMState *s = &sbdev->tpm_state;
> +
> +    return tpm_tis_get_tpm_version(s);
> +}
> +
> +static void tpm_tis_spi_reset(DeviceState *dev)
> +{
> +    TpmTisSpiState *sbdev = TPM_TIS_SPI(dev);
> +    TPMState *s = &sbdev->tpm_state;
> +
> +    return tpm_tis_reset(s);
> +}
> +
> +static Property tpm_tis_spi_properties[] = {
> +    DEFINE_PROP_UINT32("irq", TpmTisSpiState, tpm_state.irq_num, TPM_TIS_IRQ),
> +    DEFINE_PROP_TPMBE("tpmdev", TpmTisSpiState, tpm_state.be_driver),
> +    DEFINE_PROP_BOOL("ppi", TpmTisSpiState, tpm_state.ppi_enabled, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void tpm_tis_spi_realizefn(SSIPeripheral *ss, Error **errp)
> +{
> +    TpmTisSpiState *sbdev = TPM_TIS_SPI(ss);
> +
> +    if (!tpm_find()) {
> +        error_setg(errp, "at most one TPM device is permitted");
> +        return;
> +    }
> +
> +    if (!sbdev->tpm_state.be_driver) {
> +        error_setg(errp, "'tpmdev' property is required");
> +        return;
> +    }
> +
> +    DeviceState *spi_gpio = qdev_find_recursive(sysbus_get_default(),
> +                                                TYPE_SPI_GPIO);
> +    qdev_connect_gpio_out_named(spi_gpio,
> +                                "SPI_CS_out", 0,
> +                                qdev_get_gpio_in_named(DEVICE(ss),
> +                                SSI_GPIO_CS, 0));
> +}
> +
> +static void tpm_tis_spi_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
> +    TPMIfClass *tc = TPM_IF_CLASS(klass);
> +
> +    device_class_set_props(dc, tpm_tis_spi_properties);
> +    k->realize = tpm_tis_spi_realizefn;
> +    k->transfer = tpm_tis_spi_transfer8_ex;
> +    k->set_cs = tpm_tis_spi_cs;
> +    k->cs_polarity = SSI_CS_LOW;
> +
> +    dc->vmsd  = &vmstate_tpm_tis_spi;
> +    tc->model = TPM_MODEL_TPM_TIS;
> +    dc->user_creatable = true;
> +    dc->reset = tpm_tis_spi_reset;
> +    tc->request_completed = tpm_tis_spi_request_completed;
> +    tc->get_version = tpm_tis_spi_get_tpm_version;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static const TypeInfo tpm_tis_spi_info = {
> +    .name = TYPE_TPM_TIS_SPI,
> +    .parent = TYPE_SSI_PERIPHERAL,
> +    .instance_size = sizeof(TpmTisSpiState),
> +    .class_size = sizeof(TpmTisSpiClass),
> +    .class_init  = tpm_tis_spi_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_TPM_IF },
> +        { }
> +    }
> +};
> +
> +static void tpm_tis_spi_register(void)
> +{
> +    type_register_static(&tpm_tis_spi_info);
> +}
> +
> +type_init(tpm_tis_spi_register)
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index fb40e30ff6..6a6b311e47 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -46,6 +46,7 @@ struct TPMIfClass {
>  
>  #define TYPE_TPM_TIS_ISA            "tpm-tis"
>  #define TYPE_TPM_TIS_SYSBUS         "tpm-tis-device"
> +#define TYPE_TPM_TIS_SPI            "tpm-tis-spi-device"
>  #define TYPE_TPM_CRB                "tpm-crb"
>  #define TYPE_TPM_SPAPR              "tpm-spapr"
>  
> @@ -53,6 +54,8 @@ struct TPMIfClass {
>      object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
>  #define TPM_IS_TIS_SYSBUS(chr)                      \
>      object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SYSBUS)
> +#define TPM_IS_TIS_SPI(chr)                      \
> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SPI)
>  #define TPM_IS_CRB(chr)                             \
>      object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
>  #define TPM_IS_SPAPR(chr)                           \
> -- 
> 2.30.2
> 
> 


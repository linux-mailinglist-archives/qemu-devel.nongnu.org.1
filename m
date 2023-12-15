Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC28141D7
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 07:35:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE1mg-0005ZG-Mq; Fri, 15 Dec 2023 01:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irischenlj@gmail.com>)
 id 1rDyB9-0000Bo-UG; Thu, 14 Dec 2023 21:43:55 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <irischenlj@gmail.com>)
 id 1rDyB6-0001NO-Lz; Thu, 14 Dec 2023 21:43:55 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-28b1b5435c1so124300a91.2; 
 Thu, 14 Dec 2023 18:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702608225; x=1703213025; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g7yIY1t/2pqGM0mx/kf9jHGjzzX3qrBaXNa3AuE7ejQ=;
 b=LAdYYyaneJhnsVPXtBffx9+O7sLsxIY5b/VUJ87zQDC7NeoQ6rJ1mYyeLHD60yi+8V
 uu9Gk2LpM71aydmU944F/ujm+pTE3Bsa6fL1xW7Tho4vRxKidgNRlOG4KzHo1pINjeje
 zFhV1CNeIVL/YP6p40slkbjGp8MWFknOBjYrESPnXVlkPza4XzlJnzruxtpDxVCGHCY0
 bPm4FEK+9oUU8o3HrUNUV8NcHDsP6vlv2XJ3nT4logQ0kAkusoQdvKbLNUlWL9Qz9wg6
 06+3x1wRL+HqbX4OcSSflc5ua5lGmLYNpMAuyBrNHSEcZmaUrqoBQF27LYBMUuA6P1xB
 ReFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702608225; x=1703213025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g7yIY1t/2pqGM0mx/kf9jHGjzzX3qrBaXNa3AuE7ejQ=;
 b=fC7rUivSwUdon9e1BqyGJEvKWDOTp4WXVXmC4fBXmMFJTAePCmBSBTZtwCyDgWSaFA
 RLPKUdkP+p3zbwBFZKJSkfIbASO2mtzda8MtU60oKTXhKODXNnsn7IeFELSs9kvlJKlT
 HS6x54faSBNGUJqHZ2CmGPVfhEXv5owJInB3BrsbH9XWXzpxowauS8Nni54b6YdguNps
 B8kejU8U1BD5PgfkZJ3vK8iZJk9sq1YhwmwsWgVqrqMhQMA8JOdEHFyma+SVBtrnE6j4
 jP7YaOQlJHSuYiHAteq+Aabn1qpO0L0TwYGmeRBA18OLrPQc/lweMg0d3qHR/gjOqtdI
 VK2Q==
X-Gm-Message-State: AOJu0YxBiGV5aIhD5xag0I3wnwS4NlV5t/2Dou0fiQ4w+EMviFFEXLQh
 QH+bsM9By6FjKSeNCldopSGDNgjgt52Fz/OPXLo=
X-Google-Smtp-Source: AGHT+IHRjsMbojewsLx3/9FMgQgAskPP9vKmL7gF5kPY9ZombOrBSBqrVAgT/ZsP45TYpqRfYAjSUpvUJ6wiKaXmeb4=
X-Received: by 2002:a17:90a:b311:b0:28a:f0de:6be0 with SMTP id
 d17-20020a17090ab31100b0028af0de6be0mr2454083pjr.99.1702608225139; Thu, 14
 Dec 2023 18:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20220803023241.63739-1-irischenlj@gmail.com>
 <20220803023241.63739-2-irischenlj@gmail.com>
 <f3b384d6-10c7-42c7-aedb-1c4504e45085@roeck-us.net>
In-Reply-To: <f3b384d6-10c7-42c7-aedb-1c4504e45085@roeck-us.net>
From: Iris Chen <irischenlj@gmail.com>
Date: Thu, 14 Dec 2023 21:43:28 -0500
Message-ID: <CAJ9dz2jPoAScXSxvodzVJXed5oO=7v-qksftAWLVg0v3DfseWQ@mail.gmail.com>
Subject: Re: [RFC 1/1] hw: tpmtisspi: add SPI support to QEMU TPM
 implementation
To: Guenter Roeck <linux@roeck-us.net>
Cc: irischenlj@fb.com, peter@pjd.dev, pdel@fb.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, clg@kaod.org, patrick@stwcx.xyz, alistair@alistair23.me, 
 kwolf@redhat.com, hreitz@redhat.com, peter.maydell@linaro.org, 
 andrew@aj.id.au, joel@jms.id.au, thuth@redhat.com, lvivier@redhat.com, 
 pbonzini@redhat.com, qemu-block@nongnu.org, dz4list@gmail.com
Content-Type: multipart/alternative; boundary="0000000000007380c2060c835e5f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=irischenlj@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 15 Dec 2023 01:34:52 -0500
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

--0000000000007380c2060c835e5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Not from me at this moment :)

Thanks,
Iris

On Wed, Dec 13, 2023 at 9:39=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:

> Hi,
>
> On Tue, Aug 02, 2022 at 07:32:41PM -0700, Iris Chen wrote:
> > From: Iris Chen <irischenlj@fb.com>
> >
> > Signed-off-by: Iris Chen <irischenlj@fb.com>
> > ---
>
> Are there any plans to submit a new version of this patch ?
>
> Thanks,
> Guenter
>
> >  configs/devices/arm-softmmu/default.mak |   1 +
> >  hw/arm/Kconfig                          |   5 +
> >  hw/tpm/Kconfig                          |   5 +
> >  hw/tpm/meson.build                      |   1 +
> >  hw/tpm/tpm_tis_spi.c                    | 311 ++++++++++++++++++++++++
> >  include/sysemu/tpm.h                    |   3 +
> >  6 files changed, 326 insertions(+)
> >  create mode 100644 hw/tpm/tpm_tis_spi.c
> >
> > diff --git a/configs/devices/arm-softmmu/default.mak
> b/configs/devices/arm-softmmu/default.mak
> > index 6985a25377..80d2841568 100644
> > --- a/configs/devices/arm-softmmu/default.mak
> > +++ b/configs/devices/arm-softmmu/default.mak
> > @@ -42,3 +42,4 @@ CONFIG_FSL_IMX6UL=3Dy
> >  CONFIG_SEMIHOSTING=3Dy
> >  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
> >  CONFIG_ALLWINNER_H3=3Dy
> > +CONFIG_FBOBMC_AST=3Dy
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index 15fa79afd3..193decaec1 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -458,6 +458,11 @@ config ASPEED_SOC
> >      select PMBUS
> >      select MAX31785
> >
> > +config FBOBMC_AST
> > +    bool
> > +    select ASPEED_SOC
> > +    select TPM_TIS_SPI
> > +
> >  config MPS2
> >      bool
> >      imply I2C_DEVICES
> > diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> > index 29e82f3c92..370a43f045 100644
> > --- a/hw/tpm/Kconfig
> > +++ b/hw/tpm/Kconfig
> > @@ -8,6 +8,11 @@ config TPM_TIS_SYSBUS
> >      depends on TPM
> >      select TPM_TIS
> >
> > +config TPM_TIS_SPI
> > +    bool
> > +    depends on TPM
> > +    select TPM_TIS
> > +
> >  config TPM_TIS
> >      bool
> >      depends on TPM
> > diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
> > index 1c68d81d6a..1a057f4e36 100644
> > --- a/hw/tpm/meson.build
> > +++ b/hw/tpm/meson.build
> > @@ -2,6 +2,7 @@ softmmu_ss.add(when: 'CONFIG_TPM_TIS', if_true:
> files('tpm_tis_common.c'))
> >  softmmu_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true:
> files('tpm_tis_isa.c'))
> >  softmmu_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true:
> files('tpm_tis_sysbus.c'))
> >  softmmu_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
> > +softmmu_ss.add(when: 'CONFIG_TPM_TIS_SPI', if_true:
> files('tpm_tis_spi.c'))
> >
> >  specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPM_TIS'], if_true:
> files('tpm_ppi.c'))
> >  specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPM_CRB'], if_true:
> files('tpm_ppi.c'))
> > diff --git a/hw/tpm/tpm_tis_spi.c b/hw/tpm/tpm_tis_spi.c
> > new file mode 100644
> > index 0000000000..c98ddcfddb
> > --- /dev/null
> > +++ b/hw/tpm/tpm_tis_spi.c
> > @@ -0,0 +1,311 @@
> > +#include "qemu/osdep.h"
> > +#include "hw/qdev-properties.h"
> > +#include "migration/vmstate.h"
> > +#include "hw/acpi/tpm.h"
> > +#include "tpm_prop.h"
> > +#include "tpm_tis.h"
> > +#include "qom/object.h"
> > +#include "hw/ssi/ssi.h"
> > +#include "hw/ssi/spi_gpio.h"
> > +
> > +#define TPM_TIS_SPI_ADDR_BYTES 3
> > +#define SPI_WRITE 0
> > +
> > +typedef enum {
> > +    TIS_SPI_PKT_STATE_DEACTIVATED =3D 0,
> > +    TIS_SPI_PKT_STATE_START,
> > +    TIS_SPI_PKT_STATE_ADDRESS,
> > +    TIS_SPI_PKT_STATE_DATA_WR,
> > +    TIS_SPI_PKT_STATE_DATA_RD,
> > +    TIS_SPI_PKT_STATE_DONE,
> > +} TpmTisSpiPktState;
> > +
> > +union TpmTisRWSizeByte {
> > +    uint8_t byte;
> > +    struct {
> > +        uint8_t data_expected_size:6;
> > +        uint8_t resv:1;
> > +        uint8_t rwflag:1;
> > +    };
> > +};
> > +
> > +union TpmTisSpiHwAddr {
> > +    hwaddr addr;
> > +    uint8_t bytes[sizeof(hwaddr)];
> > +};
> > +
> > +union TpmTisSpiData {
> > +    uint32_t data;
> > +    uint8_t bytes[64];
> > +};
> > +
> > +struct TpmTisSpiState {
> > +    /*< private >*/
> > +    SSIPeripheral parent_obj;
> > +
> > +    /*< public >*/
> > +    TPMState tpm_state; /* not a QOM object */
> > +    TpmTisSpiPktState tpm_tis_spi_state;
> > +
> > +    union TpmTisRWSizeByte first_byte;
> > +    union TpmTisSpiHwAddr addr;
> > +    union TpmTisSpiData data;
> > +
> > +    uint32_t data_size;
> > +    uint8_t data_idx;
> > +    uint8_t addr_idx;
> > +};
> > +
> > +struct TpmTisSpiClass {
> > +    SSIPeripheralClass parent_class;
> > +};
> > +
> > +OBJECT_DECLARE_TYPE(TpmTisSpiState, TpmTisSpiClass, TPM_TIS_SPI)
> > +
> > +static void tpm_tis_spi_mmio_read(TpmTisSpiState *tts)
> > +{
> > +    uint16_t offset =3D tts->addr.addr & 0xffc;
> > +
> > +    switch (offset) {
> > +    case TPM_TIS_REG_DATA_FIFO:
> > +        for (uint8_t i =3D 0; i < tts->data_size; i++) {
> > +            tts->data.bytes[i] =3D (uint8_t)tpm_tis_memory_ops.read(
> > +                                          &tts->tpm_state,
> > +                                          tts->addr.addr,
> > +                                          1);
> > +        }
> > +        break;
> > +    default:
> > +        tts->data.data =3D (uint32_t)tpm_tis_memory_ops.read(
> > +                                   &tts->tpm_state,
> > +                                   tts->addr.addr,
> > +                                   tts->data_size);
> > +    }
> > +}
> > +
> > +static void tpm_tis_spi_mmio_write(TpmTisSpiState *tts)
> > +{
> > +    uint16_t offset =3D tts->addr.addr & 0xffc;
> > +
> > +    switch (offset) {
> > +    case TPM_TIS_REG_DATA_FIFO:
> > +        for (uint8_t i =3D 0; i < tts->data_size; i++) {
> > +            tpm_tis_memory_ops.write(&tts->tpm_state,
> > +                                     tts->addr.addr,
> > +                                     tts->data.bytes[i],
> > +                                     1);
> > +        }
> > +        break;
> > +    default:
> > +        tpm_tis_memory_ops.write(&tts->tpm_state,
> > +                                 tts->addr.addr,
> > +                                 tts->data.data,
> > +                                 tts->data_size);
> > +        }
> > +}
> > +
> > +static uint32_t tpm_tis_spi_transfer8(SSIPeripheral *ss, uint32_t tx)
> > +{
> > +    TpmTisSpiState *tts =3D TPM_TIS_SPI(ss);
> > +    uint32_t r =3D 1;
> > +
> > +    switch (tts->tpm_tis_spi_state) {
> > +    case TIS_SPI_PKT_STATE_START:
> > +        tts->first_byte.byte =3D (uint8_t)tx;
> > +        tts->data_size =3D tts->first_byte.data_expected_size + 1;
> > +        tts->data_idx =3D 0;
> > +        tts->addr_idx =3D TPM_TIS_SPI_ADDR_BYTES;
> > +        tts->tpm_tis_spi_state =3D TIS_SPI_PKT_STATE_ADDRESS;
> > +        break;
> > +    case TIS_SPI_PKT_STATE_ADDRESS:
> > +        assert(tts->addr_idx > 0);
> > +        tts->addr.bytes[--tts->addr_idx] =3D (uint8_t)tx;
> > +
> > +        if (tts->addr_idx =3D=3D 0) {
> > +            if (tts->first_byte.rwflag =3D=3D SPI_WRITE) {
> > +                tts->tpm_tis_spi_state =3D TIS_SPI_PKT_STATE_DATA_WR;
> > +            } else { /* read and get the data ready */
> > +                tpm_tis_spi_mmio_read(tts);
> > +                tts->tpm_tis_spi_state =3D TIS_SPI_PKT_STATE_DATA_RD;
> > +            }
> > +        }
> > +        break;
> > +    case TIS_SPI_PKT_STATE_DATA_WR:
> > +        tts->data.bytes[tts->data_idx++] =3D (uint8_t)tx;
> > +        if (tts->data_idx =3D=3D tts->data_size) {
> > +            tpm_tis_spi_mmio_write(tts);
> > +            tts->tpm_tis_spi_state =3D TIS_SPI_PKT_STATE_DONE;
> > +        }
> > +        break;
> > +    case TIS_SPI_PKT_STATE_DATA_RD:
> > +        r =3D tts->data.bytes[tts->data_idx++];
> > +        if (tts->data_idx =3D=3D tts->data_size) {
> > +            tts->tpm_tis_spi_state =3D TIS_SPI_PKT_STATE_DONE;
> > +        }
> > +        break;
> > +    default:
> > +        tts->tpm_tis_spi_state =3D TIS_SPI_PKT_STATE_DEACTIVATED;
> > +        r =3D (uint32_t) -1;
> > +    }
> > +
> > +    return r;
> > +}
> > +
> > +/*
> > + * Pre-reading logic for transfer:
> > + * This is to fix the transaction between reading and writing.
> > + * The first byte is arbitrarily inserted so we need to
> > + * shift the all the output bytes (timeline) one byte right.
> > + */
> > +static uint32_t tpm_tis_spi_transfer8_ex(SSIPeripheral *ss, uint32_t t=
x)
> > +{
> > +    TpmTisSpiState *tts =3D TPM_TIS_SPI(ss);
> > +    SSIBus *ssibus =3D (SSIBus *)qdev_get_parent_bus(DEVICE(tts));
> > +
> > +    TpmTisSpiPktState prev_state =3D tts->tpm_tis_spi_state;
> > +    uint32_t r =3D tpm_tis_spi_transfer8(ss, tx);
> > +    TpmTisSpiPktState curr_state =3D tts->tpm_tis_spi_state;
> > +
> > +    if (ssibus->preread &&
> > +       /* cmd state has changed into DATA reading state */
> > +       prev_state !=3D TIS_SPI_PKT_STATE_DATA_RD &&
> > +       curr_state =3D=3D TIS_SPI_PKT_STATE_DATA_RD) {
> > +        r =3D tpm_tis_spi_transfer8(ss, 0xFF);
> > +    }
> > +
> > +    return r;
> > +}
> > +
> > +static int tpm_tis_spi_cs(SSIPeripheral *ss, bool select)
> > +{
> > +    TpmTisSpiState *tts =3D TPM_TIS_SPI(ss);
> > +
> > +    if (select) { /* cs de-assert */
> > +        tts->tpm_tis_spi_state =3D TIS_SPI_PKT_STATE_DEACTIVATED;
> > +    } else {
> > +        tts->tpm_tis_spi_state =3D TIS_SPI_PKT_STATE_START;
> > +        tts->first_byte.byte =3D 0;
> > +        tts->addr.addr =3D 0;
> > +        tts->data.data =3D 0;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int tpm_tis_pre_save_spi(void *opaque)
> > +{
> > +    TpmTisSpiState *sbdev =3D opaque;
> > +
> > +    return tpm_tis_pre_save(&sbdev->tpm_state);
> > +}
> > +
> > +static const VMStateDescription vmstate_tpm_tis_spi =3D {
> > +    .name =3D "tpm-tis-spi",
> > +    .version_id =3D 0,
> > +    .pre_save  =3D tpm_tis_pre_save_spi,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_BUFFER(tpm_state.buffer, TpmTisSpiState),
> > +        VMSTATE_UINT16(tpm_state.rw_offset, TpmTisSpiState),
> > +        VMSTATE_UINT8(tpm_state.active_locty, TpmTisSpiState),
> > +        VMSTATE_UINT8(tpm_state.aborting_locty, TpmTisSpiState),
> > +        VMSTATE_UINT8(tpm_state.next_locty, TpmTisSpiState),
> > +
> > +        VMSTATE_STRUCT_ARRAY(tpm_state.loc, TpmTisSpiState,
> TPM_TIS_NUM_LOCALITIES,
> > +                             0, vmstate_locty, TPMLocality),
> > +
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void tpm_tis_spi_request_completed(TPMIf *ti, int ret)
> > +{
> > +    TpmTisSpiState *sbdev =3D TPM_TIS_SPI(ti);
> > +    TPMState *s =3D &sbdev->tpm_state;
> > +
> > +    tpm_tis_request_completed(s, ret);
> > +}
> > +
> > +static enum TPMVersion tpm_tis_spi_get_tpm_version(TPMIf *ti)
> > +{
> > +    TpmTisSpiState *sbdev =3D TPM_TIS_SPI(ti);
> > +    TPMState *s =3D &sbdev->tpm_state;
> > +
> > +    return tpm_tis_get_tpm_version(s);
> > +}
> > +
> > +static void tpm_tis_spi_reset(DeviceState *dev)
> > +{
> > +    TpmTisSpiState *sbdev =3D TPM_TIS_SPI(dev);
> > +    TPMState *s =3D &sbdev->tpm_state;
> > +
> > +    return tpm_tis_reset(s);
> > +}
> > +
> > +static Property tpm_tis_spi_properties[] =3D {
> > +    DEFINE_PROP_UINT32("irq", TpmTisSpiState, tpm_state.irq_num,
> TPM_TIS_IRQ),
> > +    DEFINE_PROP_TPMBE("tpmdev", TpmTisSpiState, tpm_state.be_driver),
> > +    DEFINE_PROP_BOOL("ppi", TpmTisSpiState, tpm_state.ppi_enabled,
> false),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void tpm_tis_spi_realizefn(SSIPeripheral *ss, Error **errp)
> > +{
> > +    TpmTisSpiState *sbdev =3D TPM_TIS_SPI(ss);
> > +
> > +    if (!tpm_find()) {
> > +        error_setg(errp, "at most one TPM device is permitted");
> > +        return;
> > +    }
> > +
> > +    if (!sbdev->tpm_state.be_driver) {
> > +        error_setg(errp, "'tpmdev' property is required");
> > +        return;
> > +    }
> > +
> > +    DeviceState *spi_gpio =3D qdev_find_recursive(sysbus_get_default()=
,
> > +                                                TYPE_SPI_GPIO);
> > +    qdev_connect_gpio_out_named(spi_gpio,
> > +                                "SPI_CS_out", 0,
> > +                                qdev_get_gpio_in_named(DEVICE(ss),
> > +                                SSI_GPIO_CS, 0));
> > +}
> > +
> > +static void tpm_tis_spi_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    SSIPeripheralClass *k =3D SSI_PERIPHERAL_CLASS(klass);
> > +    TPMIfClass *tc =3D TPM_IF_CLASS(klass);
> > +
> > +    device_class_set_props(dc, tpm_tis_spi_properties);
> > +    k->realize =3D tpm_tis_spi_realizefn;
> > +    k->transfer =3D tpm_tis_spi_transfer8_ex;
> > +    k->set_cs =3D tpm_tis_spi_cs;
> > +    k->cs_polarity =3D SSI_CS_LOW;
> > +
> > +    dc->vmsd  =3D &vmstate_tpm_tis_spi;
> > +    tc->model =3D TPM_MODEL_TPM_TIS;
> > +    dc->user_creatable =3D true;
> > +    dc->reset =3D tpm_tis_spi_reset;
> > +    tc->request_completed =3D tpm_tis_spi_request_completed;
> > +    tc->get_version =3D tpm_tis_spi_get_tpm_version;
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +}
> > +
> > +static const TypeInfo tpm_tis_spi_info =3D {
> > +    .name =3D TYPE_TPM_TIS_SPI,
> > +    .parent =3D TYPE_SSI_PERIPHERAL,
> > +    .instance_size =3D sizeof(TpmTisSpiState),
> > +    .class_size =3D sizeof(TpmTisSpiClass),
> > +    .class_init  =3D tpm_tis_spi_class_init,
> > +    .interfaces =3D (InterfaceInfo[]) {
> > +        { TYPE_TPM_IF },
> > +        { }
> > +    }
> > +};
> > +
> > +static void tpm_tis_spi_register(void)
> > +{
> > +    type_register_static(&tpm_tis_spi_info);
> > +}
> > +
> > +type_init(tpm_tis_spi_register)
> > diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> > index fb40e30ff6..6a6b311e47 100644
> > --- a/include/sysemu/tpm.h
> > +++ b/include/sysemu/tpm.h
> > @@ -46,6 +46,7 @@ struct TPMIfClass {
> >
> >  #define TYPE_TPM_TIS_ISA            "tpm-tis"
> >  #define TYPE_TPM_TIS_SYSBUS         "tpm-tis-device"
> > +#define TYPE_TPM_TIS_SPI            "tpm-tis-spi-device"
> >  #define TYPE_TPM_CRB                "tpm-crb"
> >  #define TYPE_TPM_SPAPR              "tpm-spapr"
> >
> > @@ -53,6 +54,8 @@ struct TPMIfClass {
> >      object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
> >  #define TPM_IS_TIS_SYSBUS(chr)                      \
> >      object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SYSBUS)
> > +#define TPM_IS_TIS_SPI(chr)                      \
> > +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SPI)
> >  #define TPM_IS_CRB(chr)                             \
> >      object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
> >  #define TPM_IS_SPAPR(chr)                           \
> > --
> > 2.30.2
> >
> >
>

--0000000000007380c2060c835e5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Guenter,=C2=A0<div><br></div><div>Not from me at this m=
oment :)=C2=A0</div><div><br></div><div>Thanks,=C2=A0</div><div>Iris=C2=A0<=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Wed, Dec 13, 2023 at 9:39=E2=80=AFAM Guenter Roeck &lt;<a href=3D"m=
ailto:linux@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding=
-left:1ex">Hi,<br>
<br>
On Tue, Aug 02, 2022 at 07:32:41PM -0700, Iris Chen wrote:<br>
&gt; From: Iris Chen &lt;<a href=3D"mailto:irischenlj@fb.com" target=3D"_bl=
ank">irischenlj@fb.com</a>&gt;<br>
&gt; <br>
&gt; Signed-off-by: Iris Chen &lt;<a href=3D"mailto:irischenlj@fb.com" targ=
et=3D"_blank">irischenlj@fb.com</a>&gt;<br>
&gt; ---<br>
<br>
Are there any plans to submit a new version of this patch ?<br>
<br>
Thanks,<br>
Guenter<br>
<br>
&gt;=C2=A0 configs/devices/arm-softmmu/default.mak |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 hw/tpm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 hw/tpm/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/tpm/tpm_tis_spi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 311 ++++++++++++++++++++++++<br>
&gt;=C2=A0 include/sysemu/tpm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 6 files changed, 326 insertions(+)<br>
&gt;=C2=A0 create mode 100644 hw/tpm/tpm_tis_spi.c<br>
&gt; <br>
&gt; diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices=
/arm-softmmu/default.mak<br>
&gt; index 6985a25377..80d2841568 100644<br>
&gt; --- a/configs/devices/arm-softmmu/default.mak<br>
&gt; +++ b/configs/devices/arm-softmmu/default.mak<br>
&gt; @@ -42,3 +42,4 @@ CONFIG_FSL_IMX6UL=3Dy<br>
&gt;=C2=A0 CONFIG_SEMIHOSTING=3Dy<br>
&gt;=C2=A0 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy<br>
&gt;=C2=A0 CONFIG_ALLWINNER_H3=3Dy<br>
&gt; +CONFIG_FBOBMC_AST=3Dy<br>
&gt; diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
&gt; index 15fa79afd3..193decaec1 100644<br>
&gt; --- a/hw/arm/Kconfig<br>
&gt; +++ b/hw/arm/Kconfig<br>
&gt; @@ -458,6 +458,11 @@ config ASPEED_SOC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 select PMBUS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 select MAX31785<br>
&gt;=C2=A0 <br>
&gt; +config FBOBMC_AST<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 select ASPEED_SOC<br>
&gt; +=C2=A0 =C2=A0 select TPM_TIS_SPI<br>
&gt; +<br>
&gt;=C2=A0 config MPS2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 imply I2C_DEVICES<br>
&gt; diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig<br>
&gt; index 29e82f3c92..370a43f045 100644<br>
&gt; --- a/hw/tpm/Kconfig<br>
&gt; +++ b/hw/tpm/Kconfig<br>
&gt; @@ -8,6 +8,11 @@ config TPM_TIS_SYSBUS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 depends on TPM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 select TPM_TIS<br>
&gt;=C2=A0 <br>
&gt; +config TPM_TIS_SPI<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 depends on TPM<br>
&gt; +=C2=A0 =C2=A0 select TPM_TIS<br>
&gt; +<br>
&gt;=C2=A0 config TPM_TIS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 depends on TPM<br>
&gt; diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build<br>
&gt; index 1c68d81d6a..1a057f4e36 100644<br>
&gt; --- a/hw/tpm/meson.build<br>
&gt; +++ b/hw/tpm/meson.build<br>
&gt; @@ -2,6 +2,7 @@ softmmu_ss.add(when: &#39;CONFIG_TPM_TIS&#39;, if_true=
: files(&#39;tpm_tis_common.c&#39;))<br>
&gt;=C2=A0 softmmu_ss.add(when: &#39;CONFIG_TPM_TIS_ISA&#39;, if_true: file=
s(&#39;tpm_tis_isa.c&#39;))<br>
&gt;=C2=A0 softmmu_ss.add(when: &#39;CONFIG_TPM_TIS_SYSBUS&#39;, if_true: f=
iles(&#39;tpm_tis_sysbus.c&#39;))<br>
&gt;=C2=A0 softmmu_ss.add(when: &#39;CONFIG_TPM_CRB&#39;, if_true: files(&#=
39;tpm_crb.c&#39;))<br>
&gt; +softmmu_ss.add(when: &#39;CONFIG_TPM_TIS_SPI&#39;, if_true: files(&#3=
9;tpm_tis_spi.c&#39;))<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 specific_ss.add(when: [&#39;CONFIG_SOFTMMU&#39;, &#39;CONFIG_TPM=
_TIS&#39;], if_true: files(&#39;tpm_ppi.c&#39;))<br>
&gt;=C2=A0 specific_ss.add(when: [&#39;CONFIG_SOFTMMU&#39;, &#39;CONFIG_TPM=
_CRB&#39;], if_true: files(&#39;tpm_ppi.c&#39;))<br>
&gt; diff --git a/hw/tpm/tpm_tis_spi.c b/hw/tpm/tpm_tis_spi.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..c98ddcfddb<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/tpm/tpm_tis_spi.c<br>
&gt; @@ -0,0 +1,311 @@<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;hw/acpi/tpm.h&quot;<br>
&gt; +#include &quot;tpm_prop.h&quot;<br>
&gt; +#include &quot;tpm_tis.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;hw/ssi/ssi.h&quot;<br>
&gt; +#include &quot;hw/ssi/spi_gpio.h&quot;<br>
&gt; +<br>
&gt; +#define TPM_TIS_SPI_ADDR_BYTES 3<br>
&gt; +#define SPI_WRITE 0<br>
&gt; +<br>
&gt; +typedef enum {<br>
&gt; +=C2=A0 =C2=A0 TIS_SPI_PKT_STATE_DEACTIVATED =3D 0,<br>
&gt; +=C2=A0 =C2=A0 TIS_SPI_PKT_STATE_START,<br>
&gt; +=C2=A0 =C2=A0 TIS_SPI_PKT_STATE_ADDRESS,<br>
&gt; +=C2=A0 =C2=A0 TIS_SPI_PKT_STATE_DATA_WR,<br>
&gt; +=C2=A0 =C2=A0 TIS_SPI_PKT_STATE_DATA_RD,<br>
&gt; +=C2=A0 =C2=A0 TIS_SPI_PKT_STATE_DONE,<br>
&gt; +} TpmTisSpiPktState;<br>
&gt; +<br>
&gt; +union TpmTisRWSizeByte {<br>
&gt; +=C2=A0 =C2=A0 uint8_t byte;<br>
&gt; +=C2=A0 =C2=A0 struct {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t data_expected_size:6;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t resv:1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t rwflag:1;<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +};<br>
&gt; +<br>
&gt; +union TpmTisSpiHwAddr {<br>
&gt; +=C2=A0 =C2=A0 hwaddr addr;<br>
&gt; +=C2=A0 =C2=A0 uint8_t bytes[sizeof(hwaddr)];<br>
&gt; +};<br>
&gt; +<br>
&gt; +union TpmTisSpiData {<br>
&gt; +=C2=A0 =C2=A0 uint32_t data;<br>
&gt; +=C2=A0 =C2=A0 uint8_t bytes[64];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct TpmTisSpiState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SSIPeripheral parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +=C2=A0 =C2=A0 TPMState tpm_state; /* not a QOM object */<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiPktState tpm_tis_spi_state;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 union TpmTisRWSizeByte first_byte;<br>
&gt; +=C2=A0 =C2=A0 union TpmTisSpiHwAddr addr;<br>
&gt; +=C2=A0 =C2=A0 union TpmTisSpiData data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t data_size;<br>
&gt; +=C2=A0 =C2=A0 uint8_t data_idx;<br>
&gt; +=C2=A0 =C2=A0 uint8_t addr_idx;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct TpmTisSpiClass {<br>
&gt; +=C2=A0 =C2=A0 SSIPeripheralClass parent_class;<br>
&gt; +};<br>
&gt; +<br>
&gt; +OBJECT_DECLARE_TYPE(TpmTisSpiState, TpmTisSpiClass, TPM_TIS_SPI)<br>
&gt; +<br>
&gt; +static void tpm_tis_spi_mmio_read(TpmTisSpiState *tts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint16_t offset =3D tts-&gt;addr.addr &amp; 0xffc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case TPM_TIS_REG_DATA_FIFO:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (uint8_t i =3D 0; i &lt; tts-&gt;data=
_size; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;data.bytes[i] =3D (=
uint8_t)tpm_tis_memory_ops.read(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;tts-&gt;tpm_state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tts-&gt;addr.addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;data.data =3D (uint32_t)tpm_tis_m=
emory_ops.read(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;tts-&gt;tpm_st=
ate,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tts-&gt;addr.addr,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tts-&gt;data_size);=
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void tpm_tis_spi_mmio_write(TpmTisSpiState *tts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint16_t offset =3D tts-&gt;addr.addr &amp; 0xffc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case TPM_TIS_REG_DATA_FIFO:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (uint8_t i =3D 0; i &lt; tts-&gt;data=
_size; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tpm_tis_memory_ops.write(&a=
mp;tts-&gt;tpm_state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tts-&gt;addr=
.addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tts-&gt;data=
.bytes[i],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tpm_tis_memory_ops.write(&amp;tts-&gt;tpm=
_state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tts-&gt;addr.addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tts-&gt;data.data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tts-&gt;data_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint32_t tpm_tis_spi_transfer8(SSIPeripheral *ss, uint32_t tx)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiState *tts =3D TPM_TIS_SPI(ss);<br>
&gt; +=C2=A0 =C2=A0 uint32_t r =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (tts-&gt;tpm_tis_spi_state) {<br>
&gt; +=C2=A0 =C2=A0 case TIS_SPI_PKT_STATE_START:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;first_byte.byte =3D (uint8_t)tx;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;data_size =3D tts-&gt;first_byte.=
data_expected_size + 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;data_idx =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;addr_idx =3D TPM_TIS_SPI_ADDR_BYT=
ES;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;tpm_tis_spi_state =3D TIS_SPI_PKT=
_STATE_ADDRESS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case TIS_SPI_PKT_STATE_ADDRESS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(tts-&gt;addr_idx &gt; 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;addr.bytes[--tts-&gt;addr_idx] =
=3D (uint8_t)tx;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tts-&gt;addr_idx =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tts-&gt;first_byte.rwfl=
ag =3D=3D SPI_WRITE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;tpm_t=
is_spi_state =3D TIS_SPI_PKT_STATE_DATA_WR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else { /* read and get th=
e data ready */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tpm_tis_spi_m=
mio_read(tts);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;tpm_t=
is_spi_state =3D TIS_SPI_PKT_STATE_DATA_RD;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case TIS_SPI_PKT_STATE_DATA_WR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;data.bytes[tts-&gt;data_idx++] =
=3D (uint8_t)tx;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tts-&gt;data_idx =3D=3D tts-&gt;data_=
size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tpm_tis_spi_mmio_write(tts)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;tpm_tis_spi_state =
=3D TIS_SPI_PKT_STATE_DONE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case TIS_SPI_PKT_STATE_DATA_RD:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D tts-&gt;data.bytes[tts-&gt;data_idx=
++];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tts-&gt;data_idx =3D=3D tts-&gt;data_=
size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;tpm_tis_spi_state =
=3D TIS_SPI_PKT_STATE_DONE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;tpm_tis_spi_state =3D TIS_SPI_PKT=
_STATE_DEACTIVATED;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D (uint32_t) -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return r;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Pre-reading logic for transfer:<br>
&gt; + * This is to fix the transaction between reading and writing.<br>
&gt; + * The first byte is arbitrarily inserted so we need to<br>
&gt; + * shift the all the output bytes (timeline) one byte right.<br>
&gt; + */<br>
&gt; +static uint32_t tpm_tis_spi_transfer8_ex(SSIPeripheral *ss, uint32_t =
tx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiState *tts =3D TPM_TIS_SPI(ss);<br>
&gt; +=C2=A0 =C2=A0 SSIBus *ssibus =3D (SSIBus *)qdev_get_parent_bus(DEVICE=
(tts));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiPktState prev_state =3D tts-&gt;tpm_tis_spi_st=
ate;<br>
&gt; +=C2=A0 =C2=A0 uint32_t r =3D tpm_tis_spi_transfer8(ss, tx);<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiPktState curr_state =3D tts-&gt;tpm_tis_spi_st=
ate;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ssibus-&gt;preread &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* cmd state has changed into DATA reading=
 state */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0prev_state !=3D TIS_SPI_PKT_STATE_DATA_RD =
&amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0curr_state =3D=3D TIS_SPI_PKT_STATE_DATA_R=
D) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D tpm_tis_spi_transfer8(ss, 0xFF);<br=
>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return r;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int tpm_tis_spi_cs(SSIPeripheral *ss, bool select)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiState *tts =3D TPM_TIS_SPI(ss);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (select) { /* cs de-assert */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;tpm_tis_spi_state =3D TIS_SPI_PKT=
_STATE_DEACTIVATED;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;tpm_tis_spi_state =3D TIS_SPI_PKT=
_STATE_START;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;first_byte.byte =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;addr.addr =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tts-&gt;data.data =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int tpm_tis_pre_save_spi(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiState *sbdev =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return tpm_tis_pre_save(&amp;sbdev-&gt;tpm_state);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateDescription vmstate_tpm_tis_spi =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;tpm-tis-spi&quot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 0,<br>
&gt; +=C2=A0 =C2=A0 .pre_save=C2=A0 =3D tpm_tis_pre_save_spi,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BUFFER(tpm_state.buffer, TpmTisSp=
iState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(tpm_state.rw_offset, TpmTi=
sSpiState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(tpm_state.active_locty, Tpm=
TisSpiState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(tpm_state.aborting_locty, T=
pmTisSpiState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(tpm_state.next_locty, TpmTi=
sSpiState),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_STRUCT_ARRAY(tpm_state.loc, TpmTi=
sSpiState, TPM_TIS_NUM_LOCALITIES,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, vmstate_locty, TPMLocality),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void tpm_tis_spi_request_completed(TPMIf *ti, int ret)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiState *sbdev =3D TPM_TIS_SPI(ti);<br>
&gt; +=C2=A0 =C2=A0 TPMState *s =3D &amp;sbdev-&gt;tpm_state;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 tpm_tis_request_completed(s, ret);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static enum TPMVersion tpm_tis_spi_get_tpm_version(TPMIf *ti)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiState *sbdev =3D TPM_TIS_SPI(ti);<br>
&gt; +=C2=A0 =C2=A0 TPMState *s =3D &amp;sbdev-&gt;tpm_state;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return tpm_tis_get_tpm_version(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void tpm_tis_spi_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiState *sbdev =3D TPM_TIS_SPI(dev);<br>
&gt; +=C2=A0 =C2=A0 TPMState *s =3D &amp;sbdev-&gt;tpm_state;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return tpm_tis_reset(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static Property tpm_tis_spi_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;irq&quot;, TpmTisSpiState, tpm=
_state.irq_num, TPM_TIS_IRQ),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_TPMBE(&quot;tpmdev&quot;, TpmTisSpiState, t=
pm_state.be_driver),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;ppi&quot;, TpmTisSpiState, tpm_s=
tate.ppi_enabled, false),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void tpm_tis_spi_realizefn(SSIPeripheral *ss, Error **errp)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 TpmTisSpiState *sbdev =3D TPM_TIS_SPI(ss);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!tpm_find()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;at most one TPM de=
vice is permitted&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!sbdev-&gt;tpm_state.be_driver) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;&#39;tpmdev&#39; p=
roperty is required&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 DeviceState *spi_gpio =3D qdev_find_recursive(sysbus_ge=
t_default(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_SPI_GPIO);<br>
&gt; +=C2=A0 =C2=A0 qdev_connect_gpio_out_named(spi_gpio,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;SPI_CS_out&quot;, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in_named(DEVICE(ss=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SSI_GPIO_CS, 0));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void tpm_tis_spi_class_init(ObjectClass *klass, void *data)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 SSIPeripheralClass *k =3D SSI_PERIPHERAL_CLASS(klass);<=
br>
&gt; +=C2=A0 =C2=A0 TPMIfClass *tc =3D TPM_IF_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, tpm_tis_spi_properties);<br>
&gt; +=C2=A0 =C2=A0 k-&gt;realize =3D tpm_tis_spi_realizefn;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;transfer =3D tpm_tis_spi_transfer8_ex;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;set_cs =3D tpm_tis_spi_cs;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;cs_polarity =3D SSI_CS_LOW;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd=C2=A0 =3D &amp;vmstate_tpm_tis_spi;<br>
&gt; +=C2=A0 =C2=A0 tc-&gt;model =3D TPM_MODEL_TPM_TIS;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;user_creatable =3D true;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D tpm_tis_spi_reset;<br>
&gt; +=C2=A0 =C2=A0 tc-&gt;request_completed =3D tpm_tis_spi_request_comple=
ted;<br>
&gt; +=C2=A0 =C2=A0 tc-&gt;get_version =3D tpm_tis_spi_get_tpm_version;<br>
&gt; +=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc-&gt;categories);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo tpm_tis_spi_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_TPM_TIS_SPI,<br>
&gt; +=C2=A0 =C2=A0 .parent =3D TYPE_SSI_PERIPHERAL,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(TpmTisSpiState),<br>
&gt; +=C2=A0 =C2=A0 .class_size =3D sizeof(TpmTisSpiClass),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =3D tpm_tis_spi_class_init,<br>
&gt; +=C2=A0 =C2=A0 .interfaces =3D (InterfaceInfo[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { TYPE_TPM_IF },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void tpm_tis_spi_register(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;tpm_tis_spi_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(tpm_tis_spi_register)<br>
&gt; diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h<br>
&gt; index fb40e30ff6..6a6b311e47 100644<br>
&gt; --- a/include/sysemu/tpm.h<br>
&gt; +++ b/include/sysemu/tpm.h<br>
&gt; @@ -46,6 +46,7 @@ struct TPMIfClass {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define TYPE_TPM_TIS_ISA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;tpm-tis&quot;<br>
&gt;=C2=A0 #define TYPE_TPM_TIS_SYSBUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&qu=
ot;tpm-tis-device&quot;<br>
&gt; +#define TYPE_TPM_TIS_SPI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &qu=
ot;tpm-tis-spi-device&quot;<br>
&gt;=C2=A0 #define TYPE_TPM_CRB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;tpm-crb&quot;<br>
&gt;=C2=A0 #define TYPE_TPM_SPAPR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;tpm-spapr&quot;<br>
&gt;=C2=A0 <br>
&gt; @@ -53,6 +54,8 @@ struct TPMIfClass {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)=
<br>
&gt;=C2=A0 #define TPM_IS_TIS_SYSBUS(chr)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SYSB=
US)<br>
&gt; +#define TPM_IS_TIS_SPI(chr)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SPI)<br>
&gt;=C2=A0 #define TPM_IS_CRB(chr)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)<br>
&gt;=C2=A0 #define TPM_IS_SPAPR(chr)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -- <br>
&gt; 2.30.2<br>
&gt; <br>
&gt; <br>
</blockquote></div>

--0000000000007380c2060c835e5f--


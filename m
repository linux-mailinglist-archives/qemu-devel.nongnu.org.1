Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5616578F805
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 07:36:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbwo1-0003Pq-Pz; Fri, 01 Sep 2023 01:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qbwnz-0003PU-Cw; Fri, 01 Sep 2023 01:34:51 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qbwnv-0007CZ-Tr; Fri, 01 Sep 2023 01:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wUBCu0jHrDE8d0SGIGaIGMuLWR1N05wGv8kb7zQkQPY=; b=CvzUeDvKQEikmEAGKFpVsbedMv
 6BZ7+oFIXhpOxEc+vsNeu1BQeAv6tt/wopmR/WemS9Vc1lmRgvQ2rS8WX/nP+p8WNiVAvR1WAhlcO
 7yExkMoHlGaheB31BmLMR5hb0wSp1vWoNtU9WXkFsAMEQDDr8BQnYr6qkkKM3bkA8aa7YguGXOTPa
 /r45Rixqtgp6ukSXsouj23lOMRHCPa+nLsxG9n593+SLn5EYpwlQpxbPEGRLz99Nl3hj2XJzaLoi5
 sVroFta0BACLYZFU71cbujlNPUIQv83RSTaReBLr+3eWuJgsyVQOikIPB1qb4//oE8QEvVVzJPFkt
 9tYSIi7hQjNYu1M1bvTW5gSFuNAwk0Evj39WQpNwSYY86GTTJo65bOdIEW0cBOtm2YVqzrNKj9Yqb
 NoK4Gjq8lpUGqQ8yHKIPgxulgGaD3E8YoBXfDOxcLHLV5+/jUAozVL/PitNyPf+xfFqMSjAwVxyqy
 qWSFSXrxwzNoMaLJ23PiRJLpFkyPvXmXAmrGS0/wl6chkq4jjTelFsXpH0cFHtfQIC7/Qf23FAZBA
 WMHuo2daAqTMftZwU2fIFm+WjOhJLk8PjAtA9HtOHyt6pNJhx6y8/nPLrl6dRNqtgosY0U8FvHlOZ
 y/RMX2RBxdWuCFf9KeC6sOqJM9jE0W1TZ3+gmhNno=;
Received: from [2a00:23c4:8bae:9a00:e29b:2528:c042:5a0c]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qbwnJ-0000Lm-PU; Fri, 01 Sep 2023 06:34:13 +0100
Message-ID: <3f766253-9fc6-5cac-3d1f-17ce6acd88d8@ilande.co.uk>
Date: Fri, 1 Sep 2023 06:34:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-8-graf@amazon.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230830161425.91946-8-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bae:9a00:e29b:2528:c042:5a0c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 07/12] hw/vmapple/aes: Introduce aes engine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 30/08/2023 17:14, Alexander Graf wrote:

Hi Alex,

> VMApple contains an "aes" engine device that it uses to encrypt and
> decrypt its nvram. It has trivial hard coded keys it uses for that
> purpose.
> 
> Add device emulation for this device model.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/vmapple/aes.c        | 583 ++++++++++++++++++++++++++++++++++++++++
>   hw/vmapple/Kconfig      |   2 +
>   hw/vmapple/meson.build  |   1 +
>   hw/vmapple/trace-events |  18 ++
>   4 files changed, 604 insertions(+)
>   create mode 100644 hw/vmapple/aes.c
> 
> diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c
> new file mode 100644
> index 0000000000..eaf1e26abe
> --- /dev/null
> +++ b/hw/vmapple/aes.c
> @@ -0,0 +1,583 @@
> +/*
> + * QEMU Apple AES device emulation
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +#include "hw/sysbus.h"
> +#include "crypto/hash.h"
> +#include "crypto/aes.h"
> +#include "crypto/cipher.h"
> +
> +#define TYPE_AES          "apple-aes"
> +#define MAX_FIFO_SIZE     9
> +
> +#define CMD_KEY           0x1
> +#define CMD_KEY_CONTEXT_SHIFT    27
> +#define CMD_KEY_CONTEXT_MASK     (0x1 << CMD_KEY_CONTEXT_SHIFT)
> +#define CMD_KEY_SELECT_SHIFT     24
> +#define CMD_KEY_SELECT_MASK      (0x7 << CMD_KEY_SELECT_SHIFT)
> +#define CMD_KEY_KEY_LEN_SHIFT    22
> +#define CMD_KEY_KEY_LEN_MASK     (0x3 << CMD_KEY_KEY_LEN_SHIFT)
> +#define CMD_KEY_ENCRYPT_SHIFT    20
> +#define CMD_KEY_ENCRYPT_MASK     (0x1 << CMD_KEY_ENCRYPT_SHIFT)
> +#define CMD_KEY_BLOCK_MODE_SHIFT 16
> +#define CMD_KEY_BLOCK_MODE_MASK  (0x3 << CMD_KEY_BLOCK_MODE_SHIFT)
> +#define CMD_IV            0x2
> +#define CMD_IV_CONTEXT_SHIFT     26
> +#define CMD_IV_CONTEXT_MASK      (0x3 << CMD_KEY_CONTEXT_SHIFT)
> +#define CMD_DSB           0x3
> +#define CMD_SKG           0x4
> +#define CMD_DATA          0x5
> +#define CMD_DATA_KEY_CTX_SHIFT   27
> +#define CMD_DATA_KEY_CTX_MASK    (0x1 << CMD_DATA_KEY_CTX_SHIFT)
> +#define CMD_DATA_IV_CTX_SHIFT    25
> +#define CMD_DATA_IV_CTX_MASK     (0x3 << CMD_DATA_IV_CTX_SHIFT)
> +#define CMD_DATA_LEN_MASK        0xffffff
> +#define CMD_STORE_IV      0x6
> +#define CMD_STORE_IV_ADDR_MASK   0xffffff
> +#define CMD_WRITE_REG     0x7
> +#define CMD_FLAG          0x8
> +#define CMD_FLAG_STOP_MASK       BIT(26)
> +#define CMD_FLAG_RAISE_IRQ_MASK  BIT(27)
> +#define CMD_FLAG_INFO_MASK       0xff
> +#define CMD_MAX           0x10
> +
> +#define CMD_SHIFT         28
> +
> +#define REG_STATUS            0xc
> +#define REG_STATUS_DMA_READ_RUNNING     BIT(0)
> +#define REG_STATUS_DMA_READ_PENDING     BIT(1)
> +#define REG_STATUS_DMA_WRITE_RUNNING    BIT(2)
> +#define REG_STATUS_DMA_WRITE_PENDING    BIT(3)
> +#define REG_STATUS_BUSY                 BIT(4)
> +#define REG_STATUS_EXECUTING            BIT(5)
> +#define REG_STATUS_READY                BIT(6)
> +#define REG_STATUS_TEXT_DPA_SEEDED      BIT(7)
> +#define REG_STATUS_UNWRAP_DPA_SEEDED    BIT(8)
> +
> +#define REG_IRQ_STATUS        0x18
> +#define REG_IRQ_STATUS_INVALID_CMD      BIT(2)
> +#define REG_IRQ_STATUS_FLAG             BIT(5)
> +#define REG_IRQ_ENABLE        0x1c
> +#define REG_WATERMARK         0x20
> +#define REG_Q_STATUS          0x24
> +#define REG_FLAG_INFO         0x30
> +#define REG_FIFO              0x200
> +
> +static const uint32_t key_lens[4] = {
> +    [0] = 16,
> +    [1] = 24,
> +    [2] = 32,
> +    [3] = 64,
> +};
> +
> +struct key {
> +    uint32_t key_len;
> +    uint32_t key[8];
> +};
> +
> +struct iv {
> +    uint32_t iv[4];
> +};
> +
> +struct context {
> +    struct key key;
> +    struct iv iv;
> +};
> +
> +static struct key builtin_keys[7] = {
> +    [1] = {
> +        .key_len = 32,
> +        .key = { 0x1 },
> +    },
> +    [2] = {
> +        .key_len = 32,
> +        .key = { 0x2 },
> +    },
> +    [3] = {
> +        .key_len = 32,
> +        .key = { 0x3 },
> +    }
> +};

For the QOM type below:

> +typedef struct AESState {
> +    /* Private */
> +    SysBusDevice parent_obj;
> +
> +    /* Public */
> +    qemu_irq irq;
> +    MemoryRegion iomem1;
> +    MemoryRegion iomem2;
> +
> +    uint32_t status;
> +    uint32_t q_status;
> +    uint32_t irq_status;
> +    uint32_t irq_enable;
> +    uint32_t watermark;
> +    uint32_t flag_info;
> +    uint32_t fifo[MAX_FIFO_SIZE];
> +    uint32_t fifo_idx;
> +    struct key key[2];
> +    struct iv iv[4];
> +    bool is_encrypt;
> +    QCryptoCipherMode block_mode;
> +} AESState;
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AESState, AES)

... down to here, this should live in a separate .h file so that users of the device 
can include the header and reference TYPE_AES instead of hardcoding the type string. 
Possibly you may also want to rename the type since this AES implementation appears 
to be very Apple specific :)

Note that you can also drop the typedef as this is handled by the OBJECT_*_TYPE() 
macros for you. Also we don't use separate "/* Private */" and "/* Public */" 
comments anymore so they can also be removed: we assume that everything is now 
private and "public" access occurs by declaring a QOM/qdev property.

> +static void aes_update_irq(AESState *s)
> +{
> +    qemu_set_irq(s->irq, !!(s->irq_status & s->irq_enable));
> +}
> +
> +static uint64_t aes1_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AESState *s = opaque;
> +    uint64_t res = 0;
> +
> +    switch (offset) {
> +    case REG_STATUS:
> +        res = s->status;
> +        break;
> +    case REG_IRQ_STATUS:
> +        res = s->irq_status;
> +        break;
> +    case REG_IRQ_ENABLE:
> +        res = s->irq_enable;
> +        break;
> +    case REG_WATERMARK:
> +        res = s->watermark;
> +        break;
> +    case REG_Q_STATUS:
> +        res = s->q_status;
> +        break;
> +    case REG_FLAG_INFO:
> +        res = s->flag_info;
> +        break;
> +
> +    default:
> +        trace_aes_read_unknown(offset);
> +        break;
> +    }
> +
> +    trace_aes_read(offset, res);
> +
> +    return res;
> +}
> +
> +static void fifo_append(AESState *s, uint64_t val)
> +{
> +    if (s->fifo_idx == MAX_FIFO_SIZE) {
> +        /* Exceeded the FIFO. Bail out */
> +        return;
> +    }
> +
> +    s->fifo[s->fifo_idx++] = val;
> +}

Rather than re-invent the FIFO here, can you make use of the Fifo8 type in util/fifo8.c?

> +static bool has_payload(AESState *s, uint32_t elems)
> +{
> +    return s->fifo_idx >= (elems + 1);
> +}
> +
> +static bool cmd_key(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0];
> +    uint32_t key_select = (cmd & CMD_KEY_SELECT_MASK) >> CMD_KEY_SELECT_SHIFT;
> +    uint32_t ctxt = (cmd & CMD_KEY_CONTEXT_MASK) >> CMD_KEY_CONTEXT_SHIFT;
> +    uint32_t key_len;
> +
> +    switch ((cmd & CMD_KEY_BLOCK_MODE_MASK) >> CMD_KEY_BLOCK_MODE_SHIFT) {
> +    case 0:
> +        s->block_mode = QCRYPTO_CIPHER_MODE_ECB;
> +        break;
> +    case 1:
> +        s->block_mode = QCRYPTO_CIPHER_MODE_CBC;
> +        break;
> +    default:
> +        return false;
> +    }
> +
> +    s->is_encrypt = !!((cmd & CMD_KEY_ENCRYPT_MASK) >> CMD_KEY_ENCRYPT_SHIFT);
> +    key_len = key_lens[((cmd & CMD_KEY_KEY_LEN_MASK) >> CMD_KEY_KEY_LEN_SHIFT)];
> +
> +    if (key_select) {
> +        trace_aes_cmd_key_select_builtin(ctxt, key_select,
> +                                         s->is_encrypt ? "en" : "de",
> +                                         QCryptoCipherMode_str(s->block_mode));
> +        s->key[ctxt] = builtin_keys[key_select];
> +    } else {
> +        trace_aes_cmd_key_select_new(ctxt, key_len,
> +                                     s->is_encrypt ? "en" : "de",
> +                                     QCryptoCipherMode_str(s->block_mode));
> +        if (key_len > sizeof(s->key[ctxt].key)) {
> +            return false;
> +        }
> +        if (!has_payload(s, key_len / sizeof(uint32_t))) {
> +            /* wait for payload */
> +            return false;
> +        }
> +        memcpy(&s->key[ctxt].key, &s->fifo[1], key_len);
> +        s->key[ctxt].key_len = key_len;
> +    }
> +
> +    return true;
> +}
> +
> +static bool cmd_iv(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0];
> +    uint32_t ctxt = (cmd & CMD_IV_CONTEXT_MASK) >> CMD_IV_CONTEXT_SHIFT;
> +
> +    if (!has_payload(s, 4)) {
> +        /* wait for payload */
> +        return false;
> +    }
> +    memcpy(&s->iv[ctxt].iv, &s->fifo[1], sizeof(s->iv[ctxt].iv));
> +    trace_aes_cmd_iv(ctxt, s->fifo[1], s->fifo[2], s->fifo[3], s->fifo[4]);
> +
> +    return true;
> +}
> +
> +static char hexdigit2str(uint8_t val)
> +{
> +    g_assert(val < 0x10);
> +    if (val >= 0xa) {
> +        return 'a' + (val - 0xa);
> +    } else {
> +        return '0' + val;
> +    }
> +}
> +
> +static void dump_data(const char *desc, const void *p, size_t len)
> +{
> +    char hex[(len * 2) + 1];
> +    const uint8_t *data = p;
> +    char *hexp = hex;
> +    size_t i;
> +
> +    if (len > 0x1000) {
> +        /* Too large buffer, let's bail out */
> +        return;
> +    }
> +
> +    for (i = 0; i < len; i++) {
> +        uint8_t val = data[i];
> +        *(hexp++) = hexdigit2str(val >> 4);
> +        *(hexp++) = hexdigit2str(val & 0xf);
> +    }
> +    *hexp = '\0';
> +
> +    trace_aes_dump_data(desc, hex);
> +}
> +
> +static bool cmd_data(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0];
> +    uint32_t ctxt_iv = 0;
> +    uint32_t ctxt_key = (cmd & CMD_DATA_KEY_CTX_MASK) >> CMD_DATA_KEY_CTX_SHIFT;
> +    uint32_t len = cmd & CMD_DATA_LEN_MASK;
> +    uint64_t src_addr = s->fifo[2];
> +    uint64_t dst_addr = s->fifo[3];
> +    QCryptoCipherAlgorithm alg;
> +    QCryptoCipher *cipher;
> +    char *src;
> +    char *dst;
> +
> +    src_addr |= ((uint64_t)s->fifo[1] << 16) & 0xffff00000000ULL;
> +    dst_addr |= ((uint64_t)s->fifo[1] << 32) & 0xffff00000000ULL;
> +
> +    trace_aes_cmd_data(ctxt_key, ctxt_iv, src_addr, dst_addr, len);
> +
> +    if (!has_payload(s, 3)) {
> +        /* wait for payload */
> +        trace_aes_cmd_data_error("No payload");
> +        return false;
> +    }
> +
> +    if (ctxt_key >= ARRAY_SIZE(s->key) ||
> +        ctxt_iv >= ARRAY_SIZE(s->iv)) {
> +        /* Invalid input */
> +        trace_aes_cmd_data_error("Invalid key or iv");
> +        return false;
> +    }
> +
> +    src = g_malloc0(len);
> +    dst = g_malloc0(len);
> +
> +    cpu_physical_memory_read(src_addr, src, len);
> +
> +    dump_data("cmd_data(): src_data=", src, len);
> +
> +    switch (s->key[ctxt_key].key_len) {
> +    case 128 / 8:
> +        alg = QCRYPTO_CIPHER_ALG_AES_128;
> +        break;
> +    case 192 / 8:
> +        alg = QCRYPTO_CIPHER_ALG_AES_192;
> +        break;
> +    case 256 / 8:
> +        alg = QCRYPTO_CIPHER_ALG_AES_256;
> +        break;
> +    default:
> +        trace_aes_cmd_data_error("Invalid key len");
> +        goto err_free;
> +    }
> +    cipher = qcrypto_cipher_new(alg, s->block_mode,
> +                                (void *)s->key[ctxt_key].key,
> +                                s->key[ctxt_key].key_len, NULL);
> +    g_assert(cipher != NULL);
> +    if (s->block_mode != QCRYPTO_CIPHER_MODE_ECB) {
> +        if (qcrypto_cipher_setiv(cipher, (void *)s->iv[ctxt_iv].iv,
> +                                 sizeof(s->iv[ctxt_iv].iv), NULL) != 0) {
> +            trace_aes_cmd_data_error("Failed to set IV");
> +            goto err_free_cipher;
> +        }
> +    }
> +    if (s->is_encrypt) {
> +        if (qcrypto_cipher_encrypt(cipher, src, dst, len, NULL) != 0) {
> +            trace_aes_cmd_data_error("Encrypt failed");
> +            goto err_free_cipher;
> +        }
> +    } else {
> +        if (qcrypto_cipher_decrypt(cipher, src, dst, len, NULL) != 0) {
> +            trace_aes_cmd_data_error("Decrypt failed");
> +            goto err_free_cipher;
> +        }
> +    }
> +    qcrypto_cipher_free(cipher);
> +
> +    dump_data("cmd_data(): dst_data=", dst, len);
> +    cpu_physical_memory_write(dst_addr, dst, len);
> +    g_free(src);
> +    g_free(dst);
> +
> +    return true;
> +
> +err_free_cipher:
> +    qcrypto_cipher_free(cipher);
> +err_free:
> +    g_free(src);
> +    g_free(dst);
> +    return false;
> +}
> +
> +static bool cmd_store_iv(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0];
> +    uint32_t ctxt = (cmd & CMD_IV_CONTEXT_MASK) >> CMD_IV_CONTEXT_SHIFT;
> +    uint64_t addr = s->fifo[1];
> +
> +    if (!has_payload(s, 1)) {
> +        /* wait for payload */
> +        return false;
> +    }
> +
> +    if (ctxt >= ARRAY_SIZE(s->iv)) {
> +        /* Invalid context selected */
> +        return false;
> +    }
> +
> +    addr |= ((uint64_t)cmd << 32) & 0xff00000000ULL;
> +    cpu_physical_memory_write(addr, &s->iv[ctxt].iv, sizeof(s->iv[ctxt].iv));
> +
> +    trace_aes_cmd_store_iv(ctxt, addr, s->iv[ctxt].iv[0], s->iv[ctxt].iv[1],
> +                           s->iv[ctxt].iv[2], s->iv[ctxt].iv[3]);
> +
> +    return true;
> +}
> +
> +static bool cmd_flag(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0];
> +    uint32_t raise_irq = cmd & CMD_FLAG_RAISE_IRQ_MASK;
> +
> +    /* We always process data when it's coming in, so fire an IRQ immediately */
> +    if (raise_irq) {
> +        s->irq_status |= REG_IRQ_STATUS_FLAG;
> +    }
> +
> +    s->flag_info = cmd & CMD_FLAG_INFO_MASK;
> +
> +    trace_aes_cmd_flag(!!raise_irq, s->flag_info);
> +
> +    return true;
> +}
> +
> +static void fifo_process(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0] >> CMD_SHIFT;
> +    bool success = false;
> +
> +    if (!s->fifo_idx) {
> +        return;
> +    }
> +
> +    switch (cmd) {
> +    case CMD_KEY:
> +        success = cmd_key(s);
> +        break;
> +    case CMD_IV:
> +        success = cmd_iv(s);
> +        break;
> +    case CMD_DATA:
> +        success = cmd_data(s);
> +        break;
> +    case CMD_STORE_IV:
> +        success = cmd_store_iv(s);
> +        break;
> +    case CMD_FLAG:
> +        success = cmd_flag(s);
> +        break;
> +    default:
> +        s->irq_status |= REG_IRQ_STATUS_INVALID_CMD;
> +        break;
> +    }
> +
> +    if (success) {
> +        s->fifo_idx = 0;
> +    }
> +
> +    trace_aes_fifo_process(cmd, success ? 1 : 0);
> +}
> +
> +static void aes1_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    AESState *s = opaque;
> +
> +    trace_aes_write(offset, val);
> +
> +    switch (offset) {
> +    case REG_IRQ_STATUS:
> +        s->irq_status &= ~val;
> +        break;
> +    case REG_IRQ_ENABLE:
> +        s->irq_enable = val;
> +        break;
> +    case REG_FIFO:
> +        fifo_append(s, val);
> +        fifo_process(s);
> +        break;
> +    default:
> +        trace_aes_write_unknown(offset);
> +        return;
> +    }
> +
> +    aes_update_irq(s);
> +}
> +
> +static const MemoryRegionOps aes1_ops = {
> +    .read = aes1_read,
> +    .write = aes1_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,

Can we specifically use DEVICE_BIG_ENDIAN or DEVICE_LITTLE_ENDIAN here? 
DEVICE_NATIVE_ENDIAN should only be used as a last resort.

> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static uint64_t aes2_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint64_t res = 0;
> +
> +    switch (offset) {
> +    case 0:
> +        res = 0;
> +        break;
> +    default:
> +        trace_aes_2_read_unknown(offset);
> +        break;
> +    }
> +
> +    trace_aes_2_read(offset, res);
> +
> +    return res;
> +}
> +
> +static void aes2_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    trace_aes_2_write(offset, val);
> +
> +    switch (offset) {
> +    default:
> +        trace_aes_2_write_unknown(offset);
> +        return;
> +    }
> +}
> +
> +static const MemoryRegionOps aes2_ops = {
> +    .read = aes2_read,
> +    .write = aes2_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,

Same here.

> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void aes_reset(DeviceState *d)
> +{
> +    AESState *s = AES(d);
> +
> +    s->status = 0x3f80;
> +    s->q_status = 2;
> +    s->irq_status = 0;
> +    s->irq_enable = 0;
> +    s->watermark = 0;
> +}

For SysbusDevice you should be able to use the Resettable interface rather than use 
the legacy DeviceClass reset.

> +static void aes_init(Object *obj)
> +{
> +    AESState *s = AES(obj);
> +
> +    memory_region_init_io(&s->iomem1, obj, &aes1_ops, s, TYPE_AES, 0x4000);
> +    memory_region_init_io(&s->iomem2, obj, &aes2_ops, s, TYPE_AES, 0x4000);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem1);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem2);
> +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
> +}
> +
> +static void aes_realize(DeviceState *dev, Error **errp)
> +{
> +}

I guess you can drop this function if it isn't needed?

> +static void aes_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = aes_reset;
> +    dc->realize = aes_realize;
> +}
> +
> +static const TypeInfo aes_info = {
> +    .name          = TYPE_AES,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AESState),
> +    .class_init    = aes_class_init,
> +    .instance_init = aes_init,
> +};
> +
> +static void aes_register_types(void)
> +{
> +    type_register_static(&aes_info);
> +}
> +
> +type_init(aes_register_types)

And again DEFINE_TYPES() is what you want to use here.

> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index 8b13789179..a73504d599 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -1 +1,3 @@
> +config VMAPPLE_AES
> +    bool
>   
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> index e69de29bb2..bcd4dcb28d 100644
> --- a/hw/vmapple/meson.build
> +++ b/hw/vmapple/meson.build
> @@ -0,0 +1 @@
> +system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
> diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
> index 9ccc579048..03585cdf0f 100644
> --- a/hw/vmapple/trace-events
> +++ b/hw/vmapple/trace-events
> @@ -1,2 +1,20 @@
>   # See docs/devel/tracing.rst for syntax documentation.
>   
> +# aes.c
> +aes_read_unknown(uint64_t offset) "offset=0x%"PRIx64
> +aes_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
> +aes_cmd_key_select_builtin(uint32_t ctx, uint32_t key_id, const char *direction, const char *cipher) "[%d] Selecting builtin key %d to %scrypt with %s"
> +aes_cmd_key_select_new(uint32_t ctx, uint32_t key_len, const char *direction, const char *cipher) "[%d] Selecting new key size=%d to %scrypt with %s"
> +aes_cmd_iv(uint32_t ctx, uint32_t iv0, uint32_t iv1, uint32_t iv2, uint32_t iv3) "[%d] 0x%08x 0x%08x 0x%08x 0x%08x"
> +aes_cmd_data(uint32_t key, uint32_t iv, uint64_t src, uint64_t dst, uint32_t len) "[key=%d iv=%d] src=0x%"PRIx64" dst=0x%"PRIx64" len=0x%x"
> +aes_cmd_data_error(const char *reason) "reason=%s"
> +aes_cmd_store_iv(uint32_t ctx, uint64_t addr, uint32_t iv0, uint32_t iv1, uint32_t iv2, uint32_t iv3) "[%d] addr=0x%"PRIx64"x -> 0x%08x 0x%08x 0x%08x 0x%08x"
> +aes_cmd_flag(uint32_t raise, uint32_t flag_info) "raise=%d flag_info=0x%x"
> +aes_fifo_process(uint32_t cmd, uint32_t success) "cmd=%d success=%d"
> +aes_write_unknown(uint64_t offset) "offset=0x%"PRIx64
> +aes_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
> +aes_2_read_unknown(uint64_t offset) "offset=0x%"PRIx64
> +aes_2_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
> +aes_2_write_unknown(uint64_t offset) "offset=0x%"PRIx64
> +aes_2_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
> +aes_dump_data(const char *desc, const char *hex) "%s%s"


ATB,

Mark.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 340F5827CA8
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 02:56:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN1Lw-0007rC-UQ; Mon, 08 Jan 2024 20:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rN1Ls-0007qh-Pm
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 20:56:24 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rN1Lp-0005KW-2v
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 20:56:24 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dxvuu9p5xlMFADAA--.10537S3;
 Tue, 09 Jan 2024 09:56:13 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxXNy6p5xlpzUIAA--.21380S3; 
 Tue, 09 Jan 2024 09:56:12 +0800 (CST)
Subject: Re: [PATCH v2 1/4] hw/intc/loongarch_ipi: Use MemTxAttrs interface
 for ipi ops
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20231215100333.3933632-1-maobibo@loongson.cn>
 <20231215100333.3933632-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <83bde448-76e2-2c4a-9a06-6ebfb268b2fd@loongson.cn>
Date: Tue, 9 Jan 2024 09:56:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231215100333.3933632-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxXNy6p5xlpzUIAA--.21380S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw4UWF4xWF1fAFWUGFyxCrX_yoW3tFy5pr
 W3ur43WrWrtFnrtas5Ga4DXF1DJr1xWa4aqanxK3W09r4kWr92gFykKr9rX3ZIy34rGF4Y
 vr4xArs8WF4jyFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.383, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2023/12/15 ÏÂÎç6:03, Bibo Mao Ð´µÀ:
> There are two interface pairs for MemoryRegionOps, read/write and
> read_with_attrs/write_with_attrs. The later is better for ipi device
> emulation since initial cpu can be parsed from attrs.requester_id.
>
> And requester_id can be overrided for IOCSR_IPI_SEND and mail_send
> function when it is to forward message to another vcpu.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_ipi.c | 136 +++++++++++++++++++++++-----------------
>   1 file changed, 77 insertions(+), 59 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
> index 67858b521c..1d3449e77d 100644
> --- a/hw/intc/loongarch_ipi.c
> +++ b/hw/intc/loongarch_ipi.c
> @@ -17,14 +17,16 @@
>   #include "target/loongarch/internals.h"
>   #include "trace.h"
>   
> -static void loongarch_ipi_writel(void *, hwaddr, uint64_t, unsigned);
> -
> -static uint64_t loongarch_ipi_readl(void *opaque, hwaddr addr, unsigned size)
> +static MemTxResult loongarch_ipi_readl(void *opaque, hwaddr addr,
> +                                       uint64_t *data,
> +                                       unsigned size, MemTxAttrs attrs)
>   {
> -    IPICore *s = opaque;
> +    IPICore *s;
> +    LoongArchIPI *ipi = opaque;
>       uint64_t ret = 0;
>       int index = 0;
>   
> +    s = &ipi->ipi_core;
>       addr &= 0xff;
>       switch (addr) {
>       case CORE_STATUS_OFF:
> @@ -49,10 +51,12 @@ static uint64_t loongarch_ipi_readl(void *opaque, hwaddr addr, unsigned size)
>       }
>   
>       trace_loongarch_ipi_read(size, (uint64_t)addr, ret);
> -    return ret;
> +    *data = ret;
> +    return MEMTX_OK;
>   }
>   
> -static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
> +static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
> +                          MemTxAttrs attrs)
>   {
>       int i, mask = 0, data = 0;
>   
> @@ -62,7 +66,7 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
>        */
>       if ((val >> 27) & 0xf) {
>           data = address_space_ldl(&env->address_space_iocsr, addr,
> -                                 MEMTXATTRS_UNSPECIFIED, NULL);
> +                                 attrs, NULL);
>           for (i = 0; i < 4; i++) {
>               /* get mask for byte writing */
>               if (val & (0x1 << (27 + i))) {
> @@ -74,7 +78,7 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
>       data &= mask;
>       data |= (val >> 32) & ~mask;
>       address_space_stl(&env->address_space_iocsr, addr,
> -                      data, MEMTXATTRS_UNSPECIFIED, NULL);
> +                      data, attrs, NULL);
>   }
>   
>   static int archid_cmp(const void *a, const void *b)
> @@ -103,80 +107,72 @@ static CPUState *ipi_getcpu(int arch_id)
>       CPUArchId *archid;
>   
>       archid = find_cpu_by_archid(machine, arch_id);
> -    return CPU(archid->cpu);
> -}
> -
> -static void ipi_send(uint64_t val)
> -{
> -    uint32_t cpuid;
> -    uint8_t vector;
> -    CPUState *cs;
> -    LoongArchCPU *cpu;
> -    LoongArchIPI *s;
> -
> -    cpuid = extract32(val, 16, 10);
> -    if (cpuid >= LOONGARCH_MAX_CPUS) {
> -        trace_loongarch_ipi_unsupported_cpuid("IOCSR_IPI_SEND", cpuid);
> -        return;
> +    if (archid) {
> +        return CPU(archid->cpu);
>       }
>   
> -    /* IPI status vector */
> -    vector = extract8(val, 0, 5);
> -
> -    cs = ipi_getcpu(cpuid);
> -    cpu = LOONGARCH_CPU(cs);
> -    s = LOONGARCH_IPI(cpu->env.ipistate);
> -    loongarch_ipi_writel(&s->ipi_core, CORE_SET_OFF, BIT(vector), 4);
> +    return NULL;
>   }
>   
> -static void mail_send(uint64_t val)
> +static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
>   {
>       uint32_t cpuid;
>       hwaddr addr;
> -    CPULoongArchState *env;
>       CPUState *cs;
> -    LoongArchCPU *cpu;
>   
>       cpuid = extract32(val, 16, 10);
>       if (cpuid >= LOONGARCH_MAX_CPUS) {
>           trace_loongarch_ipi_unsupported_cpuid("IOCSR_MAIL_SEND", cpuid);
> -        return;
> +        return MEMTX_DECODE_ERROR;
>       }
>   
> -    addr = 0x1020 + (val & 0x1c);
>       cs = ipi_getcpu(cpuid);
> -    cpu = LOONGARCH_CPU(cs);
> -    env = &cpu->env;
> -    send_ipi_data(env, val, addr);
> +    if (cs == NULL) {
> +        return MEMTX_DECODE_ERROR;
> +    }
> +
> +    /* override requester_id */
> +    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
> +    attrs.requester_id = cs->cpu_index;
> +    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
> +    return MEMTX_OK;
>   }
>   
> -static void any_send(uint64_t val)
> +static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
>   {
>       uint32_t cpuid;
>       hwaddr addr;
> -    CPULoongArchState *env;
>       CPUState *cs;
> -    LoongArchCPU *cpu;
>   
>       cpuid = extract32(val, 16, 10);
>       if (cpuid >= LOONGARCH_MAX_CPUS) {
>           trace_loongarch_ipi_unsupported_cpuid("IOCSR_ANY_SEND", cpuid);
> -        return;
> +        return MEMTX_DECODE_ERROR;
>       }
>   
> -    addr = val & 0xffff;
>       cs = ipi_getcpu(cpuid);
> -    cpu = LOONGARCH_CPU(cs);
> -    env = &cpu->env;
> -    send_ipi_data(env, val, addr);
> +    if (cs == NULL) {
> +        return MEMTX_DECODE_ERROR;
> +    }
> +
> +    /* override requester_id */
> +    addr = val & 0xffff;
> +    attrs.requester_id = cs->cpu_index;
> +    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
> +    return MEMTX_OK;
>   }
>   
> -static void loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
> -                                 unsigned size)
> +static MemTxResult loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
> +                                 unsigned size, MemTxAttrs attrs)
>   {
> -    IPICore *s = opaque;
> +    LoongArchIPI *ipi = opaque;
> +    IPICore *s;
>       int index = 0;
> +    uint32_t cpuid;
> +    uint8_t vector;
> +    CPUState *cs;
>   
> +    s = &ipi->ipi_core;
>       addr &= 0xff;
>       trace_loongarch_ipi_write(size, (uint64_t)addr, val);
>       switch (addr) {
> @@ -203,17 +199,35 @@ static void loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
>           s->buf[index] = val;
>           break;
>       case IOCSR_IPI_SEND:
> -        ipi_send(val);
> +        cpuid = extract32(val, 16, 10);
> +        if (cpuid >= LOONGARCH_MAX_CPUS) {
> +            trace_loongarch_ipi_unsupported_cpuid("IOCSR_IPI_SEND", cpuid);
> +            return MEMTX_DECODE_ERROR;
> +        }
> +
> +        /* IPI status vector */
> +        vector = extract8(val, 0, 5);
> +        cs = ipi_getcpu(cpuid);
> +        if (cs == NULL) {
> +            return MEMTX_DECODE_ERROR;
> +        }
> +
> +        /* override requester_id */
> +        attrs.requester_id = cs->cpu_index;
> +        ipi = LOONGARCH_IPI(LOONGARCH_CPU(cs)->env.ipistate);
> +        loongarch_ipi_writel(ipi, CORE_SET_OFF, BIT(vector), 4, attrs);
>           break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
>           break;
>       }
> +
> +    return MEMTX_OK;
>   }
>   
>   static const MemoryRegionOps loongarch_ipi_ops = {
> -    .read = loongarch_ipi_readl,
> -    .write = loongarch_ipi_writel,
> +    .read_with_attrs = loongarch_ipi_readl,
> +    .write_with_attrs = loongarch_ipi_writel,
>       .impl.min_access_size = 4,
>       .impl.max_access_size = 4,
>       .valid.min_access_size = 4,
> @@ -222,24 +236,28 @@ static const MemoryRegionOps loongarch_ipi_ops = {
>   };
>   
>   /* mail send and any send only support writeq */
> -static void loongarch_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
> -                                 unsigned size)
> +static MemTxResult loongarch_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
> +                                        unsigned size, MemTxAttrs attrs)
>   {
> +    MemTxResult ret = MEMTX_OK;
> +
>       addr &= 0xfff;
>       switch (addr) {
>       case MAIL_SEND_OFFSET:
> -        mail_send(val);
> +        ret = mail_send(val, attrs);
>           break;
>       case ANY_SEND_OFFSET:
> -        any_send(val);
> +        ret = any_send(val, attrs);
>           break;
>       default:
>          break;
>       }
> +
> +    return ret;
>   }
>   
>   static const MemoryRegionOps loongarch_ipi64_ops = {
> -    .write = loongarch_ipi_writeq,
> +    .write_with_attrs = loongarch_ipi_writeq,
>       .impl.min_access_size = 8,
>       .impl.max_access_size = 8,
>       .valid.min_access_size = 8,
> @@ -253,7 +271,7 @@ static void loongarch_ipi_init(Object *obj)
>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>   
>       memory_region_init_io(&s->ipi_iocsr_mem, obj, &loongarch_ipi_ops,
> -                          &s->ipi_core, "loongarch_ipi_iocsr", 0x48);
> +                          s, "loongarch_ipi_iocsr", 0x48);
>   
>       /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
>       s->ipi_iocsr_mem.disable_reentrancy_guard = true;
> @@ -261,7 +279,7 @@ static void loongarch_ipi_init(Object *obj)
>       sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
>   
>       memory_region_init_io(&s->ipi64_iocsr_mem, obj, &loongarch_ipi64_ops,
> -                          &s->ipi_core, "loongarch_ipi64_iocsr", 0x118);
> +                          s, "loongarch_ipi64_iocsr", 0x118);
>       sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
>       qdev_init_gpio_out(DEVICE(obj), &s->ipi_core.irq, 1);
>   }



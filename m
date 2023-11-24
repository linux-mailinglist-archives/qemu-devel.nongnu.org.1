Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CD17F7517
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:30:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6WEn-0007mD-To; Fri, 24 Nov 2023 08:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6WEf-0007kz-9F
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:28:45 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6WEc-0002bt-PF
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:28:45 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50aab3bf71fso2500539e87.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700832519; x=1701437319; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcs5WjXwNcIflKkRMhlkF735BvGumPFtgO6g2sz7Olg=;
 b=HhdMKzc5zKrlE6D9rvJxwnM1Q8lON/S1WoRcZd5+EdKUuHj0kgVwjv8lZxU1/VDviC
 J5vP5aPK5FYi1Fyj/JSfr3CR93AC+JuzN9dGrr01LxJsq43u/1L0kdxnYR8B2nNUlMyr
 aG12MtcFT3SFt08suOd6PPQqIaGsPKkzX69JGu/1PrC6bXrgvqDiyaqSLAUGPTn2vXFi
 Vj49Q+oj45MWSIo9mUGLoBqMUJ8pwGiownR0eXuZQC+CJe3y8kU3TATwKfB12JeepZik
 RQYrZZdZ4KR7iC1GqJpRo81gbkBGKJfnpYn5aVIxy5kShc5H1AX/X+mTvnZZ7kUxUFrr
 G8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700832519; x=1701437319;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gcs5WjXwNcIflKkRMhlkF735BvGumPFtgO6g2sz7Olg=;
 b=Z9Eh9tQ1wixBbzQWNe08wdDmkQew1VLcx2wDM39HLhqBzet/6whjxqfv87iHWDCMEU
 1YU9zJ4QK5OCC/wcOWyEn6DuIXWy0eZ04wOFJVxIQDuLkmObBiq0/avlMQLjEciMjTTU
 wvF3YAVD2i4g9acBknqc+pxdlgPryXwjYTb7KeKaVkcdH5SOsal9mwUXjWiET5Eu+1M5
 MAV3sj7TEdQWaOJI9AYrvwZwqpgWRwhvoKKrZ+XiqWEE7nxcCuSLeCgQ6MbkNkdkrQnR
 03hMyRb0RtlMRpCZ6yULfnmxkXo5rhczAWUD7ke01HT92Z2gJJp1e8WAz3GXk+8PaX3e
 lusQ==
X-Gm-Message-State: AOJu0YzwRS4jH0PeDBbmelau0obJu3KjwVGR3tS7ijh6dYKnpoEpe7Ih
 WpTifsjsrZK3o3pJu0kI7Dn4fw==
X-Google-Smtp-Source: AGHT+IENe62IiVMW9pxCf41W9cwc2+u3V7KJau34fYOlINmrVA55ydGINPsmRNXurFLEiitIwjO1pg==
X-Received: by 2002:a05:6512:3694:b0:50a:7640:6a83 with SMTP id
 d20-20020a056512369400b0050a76406a83mr1814024lfs.32.1700832519359; 
 Fri, 24 Nov 2023 05:28:39 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adf8b92000000b00332e8dd713fsm2085712wra.74.2023.11.24.05.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 05:28:38 -0800 (PST)
Message-ID: <d12434ff-1832-4673-9818-68ab302f26f9@linaro.org>
Date: Fri, 24 Nov 2023 14:28:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: hw: Audit of qdev properties with same name but different types
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

I just did an audit of QDev properties from different
models sharing the same name, but of different types
(as of v8.2.0-rc1).

Nothing wrong, but some having the same meaning could
use the same type :)

Just sharing:

---
    2 addr

hw/core/generic-loader.c:183:    DEFINE_PROP_UINT64("addr", 
GenericLoaderState, addr, 0),
hw/core/guest-loader.c:115:    DEFINE_PROP_UINT64("addr", 
GuestLoaderState, addr, 0),
hw/ide/macio.c:469:    DEFINE_PROP_UINT32("addr", MACIOIDEState, addr, -1),
hw/pci/pci.c:71:    DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),

    2 base

hw/arm/armv7m.c:630:    DEFINE_PROP_UINT32("base", BitBandState, base, 0),
hw/dma/i8257.c:589:    DEFINE_PROP_INT32("base", I8257State, base, 0x00),

    2 bus_nr

hw/pci-bridge/pci_expander_bridge.c:412:    DEFINE_PROP_UINT8("bus_nr", 
PXBDev, bus_nr, 0),
hw/pci-host/xilinx-pcie.c:160:    DEFINE_PROP_UINT32("bus_nr", 
XilinxPCIEHost, bus_nr, 0),

    2 clock-frequency

hw/timer/altera_timer.c:218:    DEFINE_PROP_UINT32("clock-frequency", 
AlteraTimer, freq_hz, 0),
hw/timer/mss-timer.c:284:    DEFINE_PROP_UINT32("clock-frequency", 
MSSTimerState, freq_hz,
hw/timer/sifive_pwm.c:409:    DEFINE_PROP_UINT64("clock-frequency", 
struct SiFivePwmState,
hw/timer/stm32f2xx_timer.c:302:    DEFINE_PROP_UINT64("clock-frequency", 
struct STM32F2XXTimerState,
hw/timer/xilinx_timer.c:246:    DEFINE_PROP_UINT32("clock-frequency", 
XpsTimerState, freq_hz, 62 * 1000000),


    2 config

hw/intc/pnv_xive2.c:1939:    DEFINE_PROP_UINT64("config", PnvXive2, config,
hw/isa/pc87312.c:332:    DEFINE_PROP_UINT8("config", PC87312State, 
config, 1),

    2 core-id

target/i386/cpu.c:7788:    DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
target/i386/cpu.c:7794:    DEFINE_PROP_INT32("core-id", X86CPU, core_id, 
-1),
target/s390x/cpu.c:302:    DEFINE_PROP_UINT32("core-id", S390CPU, 
env.core_id, 0),

    2 data_width

hw/dma/pl330.c:1670:    DEFINE_PROP_UINT8("data_width", PL330State, 
data_width, 64),
hw/nvram/fw_cfg.c:1350:    DEFINE_PROP_UINT32("data_width", 
FWCfgMemState, data_width, -1),

    2 debug

hw/audio/hda-codec.c:849:    DEFINE_PROP_UINT32("debug", HDAAudioState, 
debug,   0),
hw/audio/intel-hda.c:1219:    DEFINE_PROP_UINT32("debug", IntelHDAState, 
debug, 0),
hw/display/qxl.c:2466:        DEFINE_PROP_UINT32("debug", PCIQXLDevice, 
debug, 0),
hw/usb/dev-audio.c:997:    DEFINE_PROP_UINT32("debug", USBAudioState, 
debug, 0),

hw/usb/ccid-card-emulated.c:591:    DEFINE_PROP_UINT8("debug", 
EmulatedState, debug, 0),
hw/usb/ccid-card-passthru.c:393:    DEFINE_PROP_UINT8("debug", 
PassthruState, debug, 0),
hw/usb/dev-smartcard-reader.c:1435:    DEFINE_PROP_UINT8("debug", 
USBCCIDState, debug, 0),
hw/usb/redirect.c:2578:    DEFINE_PROP_UINT8("debug", USBRedirDevice, 
debug, usbredirparser_warning),

target/riscv/cpu.c:1486:    DEFINE_PROP_BOOL("debug", RISCVCPU, 
cfg.debug, true),

    2 depth
    2 device-id

hw/i386/xen/xen_pvdevice.c:120:    DEFINE_PROP_UINT16("device-id", 
XenPVDevice, device_id, 0xffff),
hw/misc/aspeed_i3c.c:327:    DEFINE_PROP_UINT8("device-id", 
AspeedI3CDevice, id, 0),

    2 device_id

hw/block/onenand.c:837:    DEFINE_PROP_UINT16("device_id", OneNANDState, 
id.dev, 0),
hw/ipmi/ipmi_bmc_sim.c:2198:    DEFINE_PROP_UINT8("device_id", 
IPMIBmcSim, device_id, 0x20),
hw/scsi/scsi-disk.c:3141:    DEFINE_PROP_STRING("device_id", 
SCSIDiskState, device_id)

    2 frequency

hw/char/escc.c:1049:    DEFINE_PROP_UINT32("frequency", ESCCState, 
frequency,   0),
hw/misc/macio/macio.c:423:    DEFINE_PROP_UINT64("frequency", 
MacIOState, frequency, 0),
hw/misc/mos6522.c:700:    DEFINE_PROP_UINT64("frequency", MOS6522State, 
frequency, 0),
hw/timer/grlib_gptimer.c:405:    DEFINE_PROP_UINT32("frequency", 
GPTimerUnit, freq_hz,   40000000),

    2 height

hw/display/artist.c:1479:    DEFINE_PROP_UINT16("height", 
ARTISTState, height, 1024),
hw/display/cg3.c:367:    DEFINE_PROP_UINT16("height",       CG3State, 
height,    -1),
hw/display/macfb.c:762:    DEFINE_PROP_UINT32("height", 
MacfbSysBusState, macfb.height, 480),
hw/display/macfb.c:781:    DEFINE_PROP_UINT32("height", MacfbNubusState, 
macfb.height, 480),
hw/display/tcx.c:885:    DEFINE_PROP_UINT16("height",   TCXState, 
height,    -1),

    2 index

hw/char/parallel.c:607:    DEFINE_PROP_UINT32("index", ISAParallelState, 
index,   -1),
hw/char/serial-isa.c:116:    DEFINE_PROP_UINT32("index", 
ISASerialState, index,   -1),
hw/intc/goldfish_pic.c:185:    DEFINE_PROP_UINT8("index", 
GoldfishPICState, idx, 0),
hw/pci-host/mv64361.c:101:    DEFINE_PROP_UINT8("index", 
MV64361PCIState, index, 0),
hw/pci-host/pnv_phb.c:187:    DEFINE_PROP_UINT32("index", PnvPHB, 
phb_id, 0),
hw/pci-host/pnv_phb3.c:1091:    DEFINE_PROP_UINT32("index", PnvPHB3, 
phb_id, 0),
hw/pci-host/pnv_phb4.c:1692:    DEFINE_PROP_UINT32("index", PnvPHB4, 
phb_id, 0),
hw/pci-host/pnv_phb4_pec.c:287:    DEFINE_PROP_UINT32("index", 
PnvPhb4PecState, index, 0),
hw/ppc/spapr_pci.c:2086:    DEFINE_PROP_UINT32("index", SpaprPhbState, 
index, -1),

    2 iobase

hw/audio/adlib.c:302:    DEFINE_PROP_UINT32 ("iobase",  AdlibState, 
port, 0x220),
hw/audio/cs4231a.c:694:    DEFINE_PROP_UINT32 ("iobase",  CSState, port, 
0x534),
hw/audio/gus.c:296:    DEFINE_PROP_UINT32 ("iobase",  GUSState, port, 
     0x240),
hw/audio/pcspk.c:220:    DEFINE_PROP_UINT32("iobase", PCSpkState, 
iobase,  0x61),
hw/audio/sb16.c:1446:    DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 
0x220),
hw/block/fdc-isa.c:269:    DEFINE_PROP_UINT32("iobase", FDCtrlISABus, 
iobase, 0x3f0),
hw/char/debugcon.c:118:    DEFINE_PROP_UINT32("iobase", 
ISADebugconState, iobase, 0xe9),
hw/char/parallel.c:608:    DEFINE_PROP_UINT32("iobase", 
ISAParallelState, iobase,  -1),
hw/char/serial-isa.c:117:    DEFINE_PROP_UINT32("iobase", 
ISASerialState, iobase,  -1),
hw/dma/i82374.c:143:    DEFINE_PROP_UINT32("iobase", I82374State, 
iobase, 0x400),
hw/ide/isa.c:105:    DEFINE_PROP_UINT32("iobase",  ISAIDEState, iobase, 
0x1f0),
hw/intc/i8259_common.c:197:    DEFINE_PROP_UINT32("iobase", 
PICCommonState, iobase,  -1),
hw/isa/pc87312.c:331:    DEFINE_PROP_UINT16("iobase", PC87312State, 
iobase, 0x398),
hw/misc/debugexit.c:58:    DEFINE_PROP_UINT32("iobase", 
ISADebugExitState, iobase, 0x501),
hw/net/ne2000-isa.c:83:    DEFINE_PROP_UINT32("iobase", ISANE2000State, 
iobase, 0x300),
hw/rtc/m48t59-isa.c:82:    DEFINE_PROP_UINT32("iobase", M48txxISAState, 
io_base, 0x74),
hw/rtc/mc146818rtc.c:973:    DEFINE_PROP_UINT16("iobase", 
MC146818RtcState, io_base, RTC_ISA_BASE),
hw/timer/i8254_common.c:242:    DEFINE_PROP_UINT32("iobase", 
PITCommonState, iobase,  -1),

    2 it_shift

hw/char/escc.c:1050:    DEFINE_PROP_UINT32("it_shift",  ESCCState, 
it_shift,    0),
hw/display/vga-mmio.c:115:    DEFINE_PROP_UINT8("it_shift", 
VGAMmioState, it_shift, 0),
hw/net/dp8393x.c:938:    DEFINE_PROP_UINT8("it_shift", dp8393xState, 
it_shift, 0),
hw/nvram/mac_nvram.c:135:    DEFINE_PROP_UINT32("it_shift", 
MacIONVRAMState, it_shift, 0),

    2 lun

hw/scsi/scsi-bus.c:1868:    DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
hw/ufs/lu.c:279:    DEFINE_PROP_UINT8("lun", UfsLu, lun, 0),

    2 manufacturer_id

hw/block/nand.c:429:    DEFINE_PROP_UINT8("manufacturer_id", 
NANDFlashState, manf_id, 0),
hw/block/onenand.c:836:    DEFINE_PROP_UINT16("manufacturer_id", 
OneNANDState, id.man, 0),

    2 max_outputs

hw/display/qxl.c:2474:        DEFINE_PROP_UINT16("max_outputs", 
PCIQXLDevice, max_outputs, 0),
include/hw/virtio/virtio-gpu.h:164:    DEFINE_PROP_UINT32("max_outputs", 
_state, _conf.max_outputs, 1),    \

    2 num-busses

hw/ppc/pnv_i2c.c:665:    DEFINE_PROP_UINT32("num-busses", PnvI2C, 
num_busses, 1),
hw/ssi/xilinx_spips.c:1425:    DEFINE_PROP_UINT8("num-busses", 
XilinxSPIPS, num_busses, 1),

    2 numa_node

hw/pci-bridge/pci_expander_bridge.c:413: 
DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
hw/ppc/spapr_pci.c:2104:    DEFINE_PROP_UINT32("numa_node", 
SpaprPhbState, numa_node, -1),

    2 queue-size

docs/devel/migration.rst:1205:         DEFINE_PROP_UINT16("queue-size", 
VirtIOBlock, conf.queue_size, 256),
hw/block/vhost-user-blk.c:569:    DEFINE_PROP_UINT32("queue-size", 
VHostUserBlk, queue_size, 128),
hw/block/virtio-blk.c:1722:    DEFINE_PROP_UINT16("queue-size", 
VirtIOBlock, conf.queue_size, 256),
hw/virtio/vdpa-dev.c:335:    DEFINE_PROP_UINT16("queue-size", 
VhostVdpaDevice, queue_size, 0),
hw/virtio/vhost-user-fs.c:410:    DEFINE_PROP_UINT16("queue-size", 
VHostUserFS, conf.queue_size, 128),

    2 ram-size

hw/misc/allwinner-h3-dramc.c:319:    DEFINE_PROP_UINT32("ram-size", 
AwH3DramCtlState, ram_size, 256 * MiB),
hw/misc/allwinner-r40-dramc.c:469:    DEFINE_PROP_UINT32("ram-size", 
AwR40DramCtlState, ram_size, 256), /* MiB */
hw/ppc/pnv.c:2021:    DEFINE_PROP_UINT64("ram-size", PnvChip, ram_size, 0),
hw/ppc/rs6000_mc.c:212:    DEFINE_PROP_UINT32("ram-size", RS6000MCState, 
ram_size, 0),

    2 resetvec

hw/riscv/opentitan.c:307:    DEFINE_PROP_UINT32("resetvec", 
LowRISCIbexSoCState, resetvec, 0x20000400),
hw/riscv/riscv_hart.c:34:    DEFINE_PROP_UINT64("resetvec", 
RISCVHartArrayState, resetvec,
target/riscv/cpu.c:1489:    DEFINE_PROP_UINT64("resetvec", RISCVCPU, 
env.resetvec, DEFAULT_RSTVEC),

    2 revision

hw/display/qxl.c:2464:        DEFINE_PROP_UINT32("revision", 
PCIQXLDevice, revision,
hw/i2c/omap_i2c.c:515:    DEFINE_PROP_UINT8("revision", OMAPI2CState, 
revision, 0),
hw/i386/xen/xen_pvdevice.c:121:    DEFINE_PROP_UINT8("revision", 
XenPVDevice, revision, 0x01),
hw/intc/arm_gic_common.c:357:    DEFINE_PROP_UINT32("revision", 
GICState, revision, 1),
hw/intc/arm_gicv3_common.c:564:    DEFINE_PROP_UINT32("revision", 
GICv3State, revision, 3),
hw/intc/omap_intc.c:653:    DEFINE_PROP_UINT8("revision", OMAPIntcState,
hw/net/cadence_gem.c:1789:    DEFINE_PROP_UINT32("revision", 
CadenceGEMState, revision,

    2 sector-length

hw/block/pflash_cfi01.c:897:    DEFINE_PROP_UINT64("sector-length", 
PFlashCFI01, sector_len, 0),
hw/block/pflash_cfi02.c:943:    DEFINE_PROP_UINT32("sector-length", 
PFlashCFI02, uniform_sector_len, 0),

    2 shift

hw/block/onenand.c:839:    DEFINE_PROP_INT32("shift", OneNANDState, 
shift, 0),
hw/ide/mmio.c:145:    DEFINE_PROP_UINT32("shift", MMIOIDEState, shift, 0),
hw/intc/xive.c:1288:    DEFINE_PROP_UINT32("shift", XiveSource, 
esb_shift, XIVE_ESB_64K_2PAGE),
hw/intc/xive.c:2054:    DEFINE_PROP_UINT32("shift", XiveENDSource, 
esb_shift, XIVE_ESB_64K),
hw/intc/xive2.c:994:    DEFINE_PROP_UINT32("shift", Xive2EndSource, 
esb_shift, XIVE_ESB_64K),

    2 size

hw/arm/pxa2xx.c:1553:    DEFINE_PROP_UINT32("size", PXA2xxI2CState, 
region_size, 0x10000),
hw/i386/xen/xen_pvdevice.c:122:    DEFINE_PROP_UINT32("size", 
XenPVDevice, size, 0x400000),
hw/input/pckbd.c:740:    DEFINE_PROP_UINT32("size", MMIOKBDState, size, -1),
hw/intc/omap_intc.c:401:    DEFINE_PROP_UINT32("size", OMAPIntcState, 
size, 0x100),
hw/misc/empty_slot.c:83:    DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
hw/misc/unimp.c:74:    DEFINE_PROP_UINT64("size", 
UnimplementedDeviceState, size, 0),
hw/misc/xlnx-versal-xramc.c:222:    DEFINE_PROP_UINT64("size", 
XlnxXramCtrl, cfg.size, 1 * MiB),
hw/nvram/ds1225y.c:146:    DEFINE_PROP_UINT32("size", SysBusNvRamState, 
nvram.chip_size, 0x2000),
hw/nvram/mac_nvram.c:134:    DEFINE_PROP_UINT32("size", MacIONVRAMState, 
size, 0),
hw/ppc/pnv_pnor.c:116:    DEFINE_PROP_SIZE("size", PnvPnor, size, 128 * 
MiB),
hw/sparc64/sun4u.c:533:    DEFINE_PROP_UINT64("size", RamDevice, size, 0),

    2 unit

hw/block/fdc.c:458:    DEFINE_PROP_UINT32("unit", FloppyDrive, unit, -1),
hw/block/swim.c:170:    DEFINE_PROP_INT32("unit", SWIMDrive, unit, -1),
hw/ide/qdev.c:43:    DEFINE_PROP_UINT32("unit", IDEDevice, unit, -1),

    2 version

hw/audio/sb16.c:1445:    DEFINE_PROP_UINT32 ("version", SB16State, ver, 
0x0405), /* 4.5 */
hw/i386/intel_iommu.c:3327:    DEFINE_PROP_UINT32("version", 
IntelIOMMUState, version, 0),
hw/intc/apic_common.c:396:    DEFINE_PROP_UINT8("version", 
APICCommonState, version, 0x14),
hw/intc/ioapic.c:480:    DEFINE_PROP_UINT8("version", IOAPICCommonState, 
version, IOAPIC_VER_DEF),
hw/misc/eccmemctl.c:329:    DEFINE_PROP_UINT32("version", ECCState, 
version, -1),
hw/pci-host/pnv_phb.c:189:    DEFINE_PROP_UINT32("version", PnvPHB, 
version, 0),
hw/pci-host/pnv_phb.c:306:    DEFINE_PROP_UINT32("version", 
PnvPHBRootPort, version, 0),
hw/sparc/sun4m_iommu.c:372:    DEFINE_PROP_UINT32("version", IOMMUState, 
version, 0),
target/microblaze/cpu.c:368:    DEFINE_PROP_STRING("version", 
MicroBlazeCPU, cfg.version),

    3 irq

hw/audio/cs4231a.c:695:    DEFINE_PROP_UINT32 ("irq",     CSState, irq,  9),
hw/audio/gus.c:297:    DEFINE_PROP_UINT32 ("irq",     GUSState, 
emu.gusirq,  7),
hw/audio/sb16.c:1447:    DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
hw/block/fdc-isa.c:270:    DEFINE_PROP_UINT32("irq", FDCtrlISABus, irq, 6),
hw/char/parallel.c:609:    DEFINE_PROP_UINT32("irq",   ISAParallelState, 
isairq,  7),
hw/char/serial-isa.c:118:    DEFINE_PROP_UINT32("irq", 
ISASerialState, isairq,  -1),
hw/hyperv/vmbus.c:2653:    DEFINE_PROP_UINT8("irq", VMBusBridge, irq, 7),
hw/ide/isa.c:107:    DEFINE_PROP_UINT32("irq",     ISAIDEState, irqnum, 
14),
hw/ipmi/isa_ipmi_bt.c:140:    DEFINE_PROP_INT32("irq", 
ISAIPMIBTDevice, isairq,  5),
hw/ipmi/isa_ipmi_kcs.c:147:    DEFINE_PROP_INT32("irq", 
ISAIPMIKCSDevice, isairq,  5),
hw/net/ne2000-isa.c:84:    DEFINE_PROP_UINT32("irq",   ISANE2000State, 
isairq, 9),
hw/rtc/m48t59-isa.c:83:    DEFINE_PROP_UINT8("irq", M48txxISAState, 
isairq, 8),
hw/rtc/mc146818rtc.c:974:    DEFINE_PROP_UINT8("irq", MC146818RtcState, 
isairq, RTC_ISA_IRQ),
hw/tpm/tpm_tis_isa.c:95:    DEFINE_PROP_UINT32("irq", TPMStateISA, 
state.irq_num, TPM_TIS_IRQ),
hw/tpm/tpm_tis_sysbus.c:94:    DEFINE_PROP_UINT32("irq", TPMStateSysBus, 
state.irq_num, TPM_TIS_IRQ),

    3 slot

hw/ipack/ipack.c:77:    DEFINE_PROP_INT32("slot", IPackDevice, slot, -1),
hw/nubus/nubus-device.c:94:    DEFINE_PROP_INT32("slot", NubusDevice, 
slot, -1),
hw/pci/pcie_port.c:219:    DEFINE_PROP_UINT16("slot", PCIESlot, slot, 0),
hw/usb/dev-smartcard-reader.c:1175:    DEFINE_PROP_UINT32("slot", struct 
CCIDCardState, slot, 0),

    3 width

hw/block/pflash_cfi01.c:914:    DEFINE_PROP_UINT8("width", PFlashCFI01, 
bank_width, 0),
hw/block/pflash_cfi02.c:952:    DEFINE_PROP_UINT8("width", PFlashCFI02, 
width, 0),
hw/display/artist.c:1478:    DEFINE_PROP_UINT16("width", 
ARTISTState, width, 1280),
hw/display/cg3.c:366:    DEFINE_PROP_UINT16("width",        CG3State, 
width,     -1),
hw/display/macfb.c:761:    DEFINE_PROP_UINT32("width", MacfbSysBusState, 
macfb.width, 640),
hw/display/macfb.c:780:    DEFINE_PROP_UINT32("width", MacfbNubusState, 
macfb.width, 640),
hw/display/tcx.c:884:    DEFINE_PROP_UINT16("width",    TCXState, width, 
     -1),
---

Regards,

Phil.


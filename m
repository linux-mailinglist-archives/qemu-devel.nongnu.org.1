Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9A07AC52C
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 23:06:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qk9nr-0005oM-Gi; Sat, 23 Sep 2023 17:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qk9nq-0005oB-3R
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 17:04:38 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qk9nk-0008Nl-Vd
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 17:04:37 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c02e232c48so68335821fa.1
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1695503069; x=1696107869;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eNKJG6lKjVOHJlpCWdSwmjSZxEnJmDlLELrITwpupc=;
 b=Vuan/r0zlnt+k5NRJLCimsjwQ1IoOKL0wx3s2mbM0NvvzXKTCGTYO1R+ZW/MJgSZ0+
 Mt6hDQar1xai3/GR47qzUzu/XggK98vmsqJnbdabpowgNDORenqT0Ze2JWPgCGoI0oBt
 RBbU5a5HIYFiRf2/t5llZHlINnl+oBwtJGMY3v6k6hKMIdMaZtWl7fEJM0aQIPsu9KWc
 epA+4xmh4NYU4ZY6o2loeUkI2s33SRqwYta/VqpucfYam8NKNpCnf6zrWqZ0N5Ekmbht
 lFZlz4+ZDamKVXqP1aRvYZjbytUeKcYUiRnnoPB/oF1s3o+eEIwRuDWkyev6pBdoOtsw
 cjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695503069; x=1696107869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0eNKJG6lKjVOHJlpCWdSwmjSZxEnJmDlLELrITwpupc=;
 b=ErRwvD29dxVhKuOJjzYQ8nuPaCozfM87ffeUbNgqZmkqB1/lgnxc10QzCTyfgJZeWb
 7jqDouTSjADrkEzPCeKoDphsYYr9DP30k2C96XlOFVIJ7GGhTNNp4Dt3f/NtNBPsNOm6
 1sS4/uL5VK5pDvrtcZkAXwHWhx94qkIcr2Ttf158F8axflqAgKiGCG5xyl958hzrCU08
 eBjfmJ7rHBnyHrRzUeoyGmMDvwwdnSOHPUlXsm1JGKY9PwRBn1ZbqYyOPnvCDNSSA6EQ
 R/+asEpaAA7wCcA0ZRCumIT5YOgzkCm09ALDtCZPuieeK8WEJWqmRjShIQvFxhaUeOxM
 wciQ==
X-Gm-Message-State: AOJu0Yx9QS94flSblh7JyOnEtlg2EGBZ2AyouPOjZpZsk2AMVnXF5fNm
 9A4Rtcq2l8y0DUYn5Lhzd2uVQ7bYg6lMPYsPvAls0A==
X-Google-Smtp-Source: AGHT+IEK890v73TuLcT3mhnLJhUn97oDnjuvK0EkmVlnk6L6XjpJ9P94rpluL7FgndOMZBAIpsXlKYL5BHLP842mfaQ=
X-Received: by 2002:a2e:9dc3:0:b0:2bf:f5c9:2dce with SMTP id
 x3-20020a2e9dc3000000b002bff5c92dcemr2278984ljj.30.1695503069367; Sat, 23 Sep
 2023 14:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-11-graf@amazon.com>
In-Reply-To: <20230830161425.91946-11-graf@amazon.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sat, 23 Sep 2023 23:04:17 +0200
Message-ID: <CAGCz3vuEJoigyirnKaF3bOxnkvwm00_drNd4L9JPor1Nk7KjGQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] hw/vmapple/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org, 
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2a00:1450:4864:20::22f;
 envelope-from=lists@philjordan.eu; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This is a pretty big patch, but I've done my best to make sense of it.
Here's a reasonably thorough first pass review.


First off: I've tested it; it seems to broadly work as advertised!

Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>


Second: Nice work on figuring out the undocumented bits for the
vmapple-related things!


General comments/questions on code:

- This is alluded to in the comment about
PGDeviceDescriptorExt/PGIOSurfaceHostDeviceDescriptor/PGIOSurfaceHostDevice=
:
PV graphics support is useful for running an x86-64 macOS host/guest
combination as well as aarch64/vmapple. It would be more useful to
have a generic device class as well as subclasses with (a) the vmapple
specific concrete implementation, and (b) the PCI interface for
x86-64. Obviously we could merge this patch roughly as it stands and
tease out the split later=E2=80=A6
At minimum though, the device type/name for the vmapple-specific
tweaks should I think include 'vmapple' so we can separate out a
generic one later without renaming things.
(Disclosure: I have something of a vested interest in this as I've got
a working x86-64 PV Graphics patch set which I've been off-and-on
cleaning up for upstreaming, but your patch has beaten me to it. And
yes, this also means I have bandwidth for helping out with making it
happen.)

- I'm pretty sure there are some threading issues with this code. I've
commented inline where I suspect the issues. Essentially, it comes
down to ParavirtualizedGraphics.framework using Apple's GCD dispatch
queues, regardless of what constraints its calling code might have.
The display object's handler blocks fire on the specified queue; the
PGDevice's handler blocks make no guarantees about reentrancy or what
threads will be used.



Finally, I have what turned out to be lots of comments, questions,
notes, etc. of varying degree of nit-picky-ness, inline in the patch
below.

Cheers,
Phil


On Wed, Aug 30, 2023 at 6:18=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:

> +#define MAX_MRS 512

This appears to be unused.

> +
> +static const PGDisplayCoord_t apple_gfx_modes[] =3D {
> +    { .x =3D 1440, .y =3D 1080 },
> +    { .x =3D 1280, .y =3D 1024 },
> +};

Any specific reason for choosing these modes and not some more=E2=80=A6
conventional ones?

> + * We have to map PVG memory into our address space. Use the one below
> + * as base start address. In normal linker setups it points to a free
> + * memory range.
> + */
> +#define APPLE_GFX_BASE_VA ((void *)(uintptr_t)0x500000000000UL)

Hard-coding this and hoping for the best seems unnecessary? We can
just reserve a range of address space for each task on demand
(mach_vm_allocate()), with no risk of collisions. This doesn't add any
complexity. mach_vm_remap will still work.

> +typedef struct AppleGFXTask {
> +    QTAILQ_ENTRY(AppleGFXTask) node;
> +    void *mem;
> +    uint64_t len;
> +} AppleGFXTask;

Using the name PGTask_s for the struct, as used by the PV Graphics
framework, would save a bunch of casting. Any particular reason not to
use that name? (We could typedef it to something matching Qemu's
naming conventions if that's the concern.)

> +typedef QTAILQ_HEAD(, AppleGFXTask) AppleGFXTaskList;
> +
> +typedef struct AppleGFXState {
> +    /* Private */
> +    SysBusDevice parent_obj;

I saw some reviews on the other patches in the series commented on
this - I guess this way of defining QObj types no longer matches Qemu
convention.

> +static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned siz=
e)
> +{
> +    AppleGFXState *s =3D opaque;
> +    uint64_t res =3D 0;
> +
> +    switch (offset) {
> +    default:
> +        res =3D [s->pgdev mmioReadAtOffset:offset];
> +        break;
> +    }

This switch block looks like it might have had a purpose once, but is
no longer needed.

> +
> +    trace_apple_gfx_read(offset, res);
> +
> +    return res;
> +}
> +
> +static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val, u=
nsigned size)
> +{
> +    AppleGFXState *s =3D opaque;
> +
> +    trace_apple_gfx_write(offset, val);
> +
> +    qemu_mutex_unlock_iothread();
> +    [s->pgdev mmioWriteAtOffset:offset value:val];
> +    qemu_mutex_lock_iothread();
> +}

Is a momentary unlock like that safe to do here? Does the calling code
expect the lock to continue being held?

> +static uint64_t apple_iosfc_read(void *opaque, hwaddr offset, unsigned s=
ize)
> +{
> +    AppleGFXState *s =3D opaque;
> +    uint64_t res =3D 0;
> +
> +    qemu_mutex_unlock_iothread();
> +    res =3D [s->pgiosfc mmioReadAtOffset:offset];
> +    qemu_mutex_lock_iothread();

As above

> +
> +    trace_apple_iosfc_read(offset, res);
> +
> +    return res;
> +}
> +

[=E2=80=A6]

> +static void apple_gfx_fb_update_display(void *opaque)
> +{
> +    AppleGFXState *s =3D opaque;
> +
> +    if (!s->new_frame || !s->handles_frames) {
> +        return;
> +    }
> +
> +    s->new_frame =3D false;
> +
> +    BOOL r;
> +    uint32_t width =3D surface_width(s->surface);
> +    uint32_t height =3D surface_height(s->surface);
> +    MTLRegion region =3D MTLRegionMake2D(0, 0, width, height);
> +    id<MTLCommandQueue> commandQueue =3D [s->mtl newCommandQueue];
> +    id<MTLCommandBuffer> mipmapCommandBuffer =3D [commandQueue commandBu=
ffer];
> +
> +    r =3D [s->pgdisp encodeCurrentFrameToCommandBuffer:mipmapCommandBuff=
er
> +                                             texture:s->texture
> +                                              region:region];
> +
> +    if (r !=3D YES) {
> +        return;
> +    }
> +
> +    id<MTLBlitCommandEncoder> blitCommandEncoder =3D [mipmapCommandBuffe=
r blitCommandEncoder];
> +    [blitCommandEncoder generateMipmapsForTexture:s->texture];

It shouldn't be necessary to generate a mip map for the rendered
frame, especially as it's just mip level 0 being read back to a system
memory buffer below.

> +    [blitCommandEncoder endEncoding];
> +    [mipmapCommandBuffer commit];
> +    [mipmapCommandBuffer waitUntilCompleted];

Instead of waiting synchronously for the GPU to do its thing (while
holding the BQL), this would be a textbook case for using
.gfx_update_async =3D true in the GraphicHwOps. Perhaps an improvement
for a future patch though.

> +    [s->texture getBytes:s->vram bytesPerRow:(width * 4)
> +                                 bytesPerImage: (width * height * 4)
> +                                 fromRegion: region
> +                                 mipmapLevel: 0
> +                                 slice: 0];
> +
> +    /* Need to render cursor manually if not supported by backend */
> +    if (!dpy_cursor_define_supported(s->con) && s->cursor && s->cursor_s=
how) {
> +        pixman_image_t *image =3D
> +            pixman_image_create_bits(PIXMAN_a8r8g8b8,
> +                                     s->cursor->width,
> +                                     s->cursor->height,
> +                                     (uint32_t *)s->cursor->data,
> +                                     s->cursor->width * 4);
> +
> +        pixman_image_composite(PIXMAN_OP_OVER,
> +                               image, NULL, s->surface->image,
> +                               0, 0, 0, 0, s->pgdisp.cursorPosition.x,
> +                               s->pgdisp.cursorPosition.y, s->cursor->wi=
dth,
> +                               s->cursor->height);
> +
> +        pixman_image_unref(image);
> +    }
> +
> +    dpy_gfx_update_full(s->con);
> +
> +    [commandQueue release];

I notice the command buffer isn't being released. I assume that has
autorelease semantics?

> +}
> +
> +static const GraphicHwOps apple_gfx_fb_ops =3D {
> +    .gfx_update =3D apple_gfx_fb_update_display,
> +};
> +
> +static void update_cursor(AppleGFXState *s)
> +{
> +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x, s->pgdisp.cursorPo=
sition.y, s->cursor_show);
> +
> +    /* Need to render manually if cursor is not natively supported */
> +    if (!dpy_cursor_define_supported(s->con)) {
> +        s->new_frame =3D true;
> +    }
> +}
> +
> +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
> +{
> +    void *vram =3D g_malloc0(width * height * 4);
> +    void *old_vram =3D s->vram;
> +    DisplaySurface *surface;
> +    MTLTextureDescriptor *textureDescriptor;
> +    id<MTLTexture> old_texture =3D s->texture;

Accesses to various fields including s->vram and s->texture above and
more below appear to not be serialised with their uses in the gfx
update callback. So although mode setting is a fairly rare occurrence,
these accesses can race and cause use-after-free, etc.

> +
> +    if (s->surface &&
> +        width =3D=3D surface_width(s->surface) &&
> +        height =3D=3D surface_height(s->surface)) {
> +        return;
> +    }
> +    surface =3D qemu_create_displaysurface_from(width, height, PIXMAN_LE=
_a8r8g8b8,
> +                                              width * 4, vram);
> +    s->surface =3D surface;
> +    dpy_gfx_replace_surface(s->con, surface);
> +    s->vram =3D vram;
> +    g_free(old_vram);
> +
> +    textureDescriptor =3D [MTLTextureDescriptor texture2DDescriptorWithP=
ixelFormat:MTLPixelFormatBGRA8Unorm
> +                                              width:width
> +                                              height:height
> +                                              mipmapped:NO];
> +    textureDescriptor.usage =3D s->pgdisp.minimumTextureUsage;
> +    s->texture =3D [s->mtl newTextureWithDescriptor:textureDescriptor];
> +
> +    if (old_texture) {
> +        [old_texture release];
> +    }
> +}
> +


> +
> +static void apple_gfx_realize(DeviceState *dev, Error **errp)

This function keeps going and going and going, but performs a bunch of
distinct operations. Perhaps split these out into separate functions?

> +{
> +    AppleGFXState *s =3D APPLE_GFX(dev);
> +    PGDeviceDescriptor *desc =3D [PGDeviceDescriptor new];
> +    PGDisplayDescriptor *disp_desc =3D [PGDisplayDescriptor new];
> +    PGIOSurfaceHostDeviceDescriptor *iosfc_desc =3D [PGIOSurfaceHostDevi=
ceDescriptor new];

These 'new' calls don't seem to be matched by 'release' calls. This
code is only called once in the lifetime of a VM, so the leaks are of
course minor.

> +    PGDeviceDescriptorExt *desc_ext =3D (PGDeviceDescriptorExt *)desc;

I don't quite understand why we need 2 pointer variables to refer to
the same object? The base class properties are accessible via a
subclass pointer.

> +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> +        modes[i] =3D [PGDisplayMode new];

Again, no matching release.

> +        [modes[i] initWithSizeInPixels:apple_gfx_modes[i] refreshRateInH=
z:60.];
> +    }
> +
> +    s->mtl =3D MTLCreateSystemDefaultDevice();
> +
> +    desc.device =3D s->mtl;
> +    desc_ext.usingIOSurfaceMapper =3D true;
> +
> +    desc.createTask =3D ^(uint64_t vmSize, void * _Nullable * _Nonnull b=
aseAddress) {

Are we in any way certain about thread safety guarantees for this and
the other 3 "task" related handler blocks? I've seen them called from
at least 2 different dispatch queues
("com.apple.root.default-qos.overcommit" and "FIFOQueue").

> +        AppleGFXTask *task =3D apple_gfx_new_task(s, vmSize);
> +        *baseAddress =3D task->mem;
> +        trace_apple_gfx_create_task(vmSize, *baseAddress);
> +        return (PGTask_t *)task;
> +    };
> +
> +    desc.destroyTask =3D ^(PGTask_t * _Nonnull _task) {
> +        AppleGFXTask *task =3D (AppleGFXTask *)_task;
> +        trace_apple_gfx_destroy_task(task);
> +        QTAILQ_REMOVE(&s->tasks, task, node);
> +        g_free(task);
> +    };
> +
> +    desc.mapMemory =3D ^(PGTask_t * _Nonnull _task, uint32_t rangeCount,=
 uint64_t virtualOffset, bool readOnly, PGPhysicalMemoryRange_t * _Nonnull =
ranges) {
> +        AppleGFXTask *task =3D (AppleGFXTask*)_task;
> +       mach_port_t mtask =3D mach_task_self();
> +        trace_apple_gfx_map_memory(task, rangeCount, virtualOffset, read=
Only);
> +        for (int i =3D 0; i < rangeCount; i++) {
> +            PGPhysicalMemoryRange_t *range =3D &ranges[i];
> +            MemoryRegion *tmp_mr;
> +            /* TODO: Bounds checks? r/o? */
> +            qemu_mutex_lock_iothread();
> +            AppleGFXMR *mr =3D apple_gfx_mapMemory(s, task, virtualOffse=
t,
> +                                                 range->physicalAddress,
> +                                                 range->physicalLength);
> +
> +            trace_apple_gfx_map_memory_range(i, range->physicalAddress, =
range->physicalLength, mr->va);
> +
> +            vm_address_t target =3D (vm_address_t)mr->va;
> +            uint64_t mask =3D 0;
> +            bool anywhere =3D false;
> +            vm_address_t source =3D (vm_address_t)gpa2hva(&tmp_mr, mr->p=
a, mr->len, NULL);
> +            vm_prot_t cur_protection =3D 0;
> +            vm_prot_t max_protection =3D 0;
> +            kern_return_t retval =3D vm_remap(mtask, &target, mr->len, m=
ask,
> +                                            anywhere, mtask, source, fal=
se,
> +                                            &cur_protection, &max_protec=
tion,
> +                                            VM_INHERIT_DEFAULT);
> +            trace_apple_gfx_remap(retval, source, target);
> +            g_assert(retval =3D=3D KERN_SUCCESS);
> +
> +            qemu_mutex_unlock_iothread();
> +
> +            virtualOffset +=3D mr->len;
> +        }
> +        return (bool)true;
> +    };
> +
> +    desc.unmapMemory =3D ^(PGTask_t * _Nonnull _task, uint64_t virtualOf=
fset, uint64_t length) {
> +        AppleGFXTask *task =3D (AppleGFXTask *)_task;
> +        AppleGFXMR *mr, *next;
> +
> +        trace_apple_gfx_unmap_memory(task, virtualOffset, length);
> +        qemu_mutex_lock_iothread();

Why is this handler locking and the mapMemory one isn't?

> +        QTAILQ_FOREACH_SAFE(mr, &s->mrs, node, next) {

Is this a good choice of data structure for the operation? How many
list members are we expecting here, and how hot is this handler?

> +            if (mr->va >=3D (task->mem + virtualOffset) &&
> +                (mr->va + mr->len) <=3D (task->mem + virtualOffset + len=
gth)) {
> +                vm_address_t addr =3D (vm_address_t)mr->va;
> +                vm_deallocate(mach_task_self(), addr, mr->len);
> +                QTAILQ_REMOVE(&s->mrs, mr, node);
> +                g_free(mr);
> +            }
> +        }
> +        qemu_mutex_unlock_iothread();
> +        return (bool)true;
> +    };
> +


> +    desc.addTraceRange =3D ^(PGPhysicalMemoryRange_t * _Nonnull range, P=
GTraceRangeHandler _Nonnull handler) {
> +        /* Never saw this called. Return a bogus pointer so we catch acc=
ess. */
> +        return (PGTraceRange_t *)(void *)(uintptr_t)0x4242;
> +    };
> +
> +    desc.removeTraceRange =3D ^(PGTraceRange_t * _Nonnull range) {
> +        /* Never saw this called. Nothing to do. */
> +    };

The "trace range" functionality is optional, and, I believe, only used
by the UEFI driver for the PV graphics device. vmapple doesn't use
UEFI, so you won't see these called on aarch64 guests. It's safe to
not set any addTraceRange/removeTraceRange handlers, no need for dummy
ones. (Especially not ones with undefined behaviour=E2=80=A6)

> +    s->pgdev =3D PGNewDeviceWithDescriptor(desc);
> +
> +    [disp_desc init];

[PGDisplayDescriptor new] earlier already implies -init. Either use
new, or the alloc/init idiom, but not both.

> +    disp_desc.name =3D @"QEMU display";
> +    disp_desc.sizeInMillimeters =3D NSMakeSize(400., 300.); /* A 20" dis=
play */
> +    disp_desc.queue =3D dispatch_get_main_queue();

Note that the GCD main queue does not map to anything well-defined in
Qemu's view of the world. (It doesn't even necessarily map to the
process's starting thread: it's just guaranteed to be serialised with
regard to the starting thread.)

With that in mind:

> +    disp_desc.newFrameEventHandler =3D ^(void) {
> +        trace_apple_gfx_new_frame();
> +
> +        /* Tell QEMU gfx stack that a new frame arrived */
> +        s->handles_frames =3D true;
> +        s->new_frame =3D true;

Setting new_frame on the GCD main queue and performing check-and-clear
on it in the Qemu graphics fb update callback without using atomics or
locking makes me uneasy.

> +    };
> +    disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t sizeInPixels, OST=
ype pixelFormat) {
> +        trace_apple_gfx_mode_change(sizeInPixels.x, sizeInPixels.y);
> +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
> +    };
> +    disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *glyph, PGDispla=
yCoord_t hotSpot) {
> +        uint32_t bpp =3D glyph.bitsPerPixel;
> +        uint64_t width =3D glyph.pixelsWide;
> +        uint64_t height =3D glyph.pixelsHigh;
> +
> +        trace_apple_gfx_cursor_set(bpp, width, height);
> +
> +        if (s->cursor) {
> +            cursor_unref(s->cursor);
> +        }
> +        s->cursor =3D cursor_alloc(width, height);

I suspect this is not thread safe.

> +
> +        /* TODO handle different bpp */
> +        if (bpp =3D=3D 32) {
> +            memcpy(s->cursor->data, glyph.bitmapData, glyph.bytesPerPlan=
e);
> +            dpy_cursor_define(s->con, s->cursor);
> +            update_cursor(s);
> +        }
> +    };
> +    disp_desc.cursorShowHandler =3D ^(BOOL show) {
> +        trace_apple_gfx_cursor_show(show);
> +        s->cursor_show =3D show;
> +        update_cursor(s);
> +    };
> +    disp_desc.cursorMoveHandler =3D ^(void) {
> +        trace_apple_gfx_cursor_move();
> +        update_cursor(s);
> +    };

Note that cursorMoveHandler wasn't in every API version of the PV
Graphics framework, although it was only missing from macOS 11.0 and
was added with 11.1, so I suspect the issue is fairly theoretical.
(I'm not sure what you're supposed to use instead, I guess polling
cursorPosition on every frame? In any case, setting cursorMoveHandler
will crash on runtime versions where it's not available unless wrapped
in an availability check.)

> +    s->pgdisp =3D [s->pgdev newDisplayWithDescriptor:disp_desc port:0 se=
rialNum:1234];
> +    s->pgdisp.modeList =3D [NSArray arrayWithObjects:modes count:ARRAY_S=
IZE(apple_gfx_modes)];
> +
> +    [iosfc_desc init];
> +    iosfc_desc.mapMemory =3D ^(uint64_t phys, uint64_t len, bool ro, voi=
d **va, void *e, void *f) {

I assume we don't really have any concrete information on the meaning
of the unused arguments?

> +        trace_apple_iosfc_map_memory(phys, len, ro, va, e, f);
> +        MemoryRegion *tmp_mr;
> +        *va =3D gpa2hva(&tmp_mr, phys, len, NULL);
> +        return (bool)true;
> +    };
> +


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B59C79F1B8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVCT-000071-Pl; Wed, 13 Sep 2023 15:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgVCR-00006d-Bo
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:06:55 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgVCO-0007br-P2
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:06:55 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ab244e7113so70052b6e.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694632011; x=1695236811; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e7eil43de4H6tS8C7n4z8OeAGLpjZydzRmA57AVHxDw=;
 b=T0Y1hc8ILj6RvixS5fhK8jG4qS8f2C9RA0JNF7HdH7siYN3XPM+DVpFwhOZPfm7bEp
 OV4T8NKv/Me4TLuo3IPu/Og86GtauXweiPE44sjzhuRnGIp4QfiHIZ9/aWaM8eiEI321
 ou4vrqm/P92pAlHPuLA1eg1fNFiTLACwaUHzoHldIo6MbzatdPdazSJLqNQDOCf8J6V3
 LliNxJtM4c2octsOSovwvS4E/77ol5xNT2Tgx7quxXJjCZR8AR6mC/l39EI0777iZ342
 wlJPKCMnS0YOZLDafas+xElWDAvb+uT5fZayqoTtf+CUAEwZDrE1e4Q1VF0td5Vsw3P7
 bgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694632011; x=1695236811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e7eil43de4H6tS8C7n4z8OeAGLpjZydzRmA57AVHxDw=;
 b=R5LSRdjdHzIN3ALPeZnUSZPmE1Ni3tzLycuBbH/vNJp2Z7Q2n1lP2syhPfEuCbnXi+
 b2jqX3gb1RuBx8uEAupMcXEB2XykNDjyOSGcDxJ/aLyhG/TQ3c6smxxKHg3bJn0au1vA
 QQ6J8fepENjYdGiFwQ2jnbmZmhayB8WKrDHzMTo/FndIHuWSVLAjXwyc9t6wwVMB2IPA
 5cgZwqxungN7Sa/QqNoQJs16zNF3bGIBPytC3806RmixPydq84YYznwITW2l2vNAMYPx
 JfznHLicAnQE65WbbzkohLPDCORbUi56V/tJUPkN6v7N51LEEaKvp7+hXUrl9av3z2/g
 uxyw==
X-Gm-Message-State: AOJu0Yw5WtxcS45ZAFGPJp1sk+ykEtdbPvHJ/va+eOqi6dbqBAG/MUkb
 p9OyKOA11pyTiTERL5xcddH4icGQWDrEVmwY0Uo=
X-Google-Smtp-Source: AGHT+IHQL972O65gIu8WxFWRBu73Wtzzj+zSWRO81YA2K1OeVaqLmhIgu4TIG1CXtqj9jB4O7y1TrwkUt8OXEiaDHU0=
X-Received: by 2002:a05:6870:179d:b0:1bf:87af:e6df with SMTP id
 r29-20020a056870179d00b001bf87afe6dfmr3801602oae.55.1694632011289; Wed, 13
 Sep 2023 12:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXv4Kds=Yqt+hyX4ngOYLfU=nyKASSyMr0OP6_+Mw=sqA@mail.gmail.com>
In-Reply-To: <CAJSP0QXv4Kds=Yqt+hyX4ngOYLfU=nyKASSyMr0OP6_+Mw=sqA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 13 Sep 2023 15:06:39 -0400
Message-ID: <CAJSP0QWPNU-WyW6v45zgwO=2U97F_ex7Ctk17F-oWDpXSJmFiA@mail.gmail.com>
Subject: Re: Assertion `dpy_ui_info_supported(con)' failed
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Oops, I forgot to CC qemu-devel.

On Wed, 13 Sept 2023 at 15:06, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> I can't start a qemu.git build with a GTK UI but -display vnc=:0 works:
>
> $ ./configure --target-list=x86_64-softmmu
> $ build/qemu-system-x86_64
> qemu-system-x86_64: ../ui/console.c:818: dpy_get_ui_info: Assertion
> `dpy_ui_info_supported(con)' failed.
>
> Here is the configure output:
>   Build environment
>     Build directory                              : /home/stefanha/qemu/build
>     Source path                                  : /home/stefanha/qemu
>     Download dependencies                        : YES
>
>   Directories
>     Build directory                              : /home/stefanha/qemu/build
>     Source path                                  : /home/stefanha/qemu
>     Download dependencies                        : YES
>     Install prefix                               : /usr/local
>     BIOS directory                               : share/qemu
>     firmware path                                : share/qemu-firmware
>     binary directory                             : /usr/local/bin
>     library directory                            : /usr/local/lib64
>     module directory                             : lib64/qemu
>     libexec directory                            : /usr/local/libexec
>     include directory                            : /usr/local/include
>     config directory                             : /usr/local/etc
>     local state directory                        : /var/local
>     Manual directory                             : /usr/local/share/man
>     Doc directory                                : /usr/local/share/doc
>
>   Host binaries
>     python                                       :
> /home/stefanha/qemu/build/pyvenv/bin/python3 (version: 3.11)
>     sphinx-build                                 :
> /home/stefanha/qemu/build/pyvenv/bin/sphinx-build
>     gdb                                          : /usr/bin/gdb
>     iasl                                         : NO
>     genisoimage                                  : /usr/bin/genisoimage
>     smbd                                         : /usr/sbin/smbd
>
>   Configurable features
>     Documentation                                : YES
>     system-mode emulation                        : YES
>     user-mode emulation                          : NO
>     block layer                                  : YES
>     Install blobs                                : YES
>     module support                               : NO
>     fuzzing support                              : NO
>     Audio drivers                                : pa oss
>     Trace backends                               : log
>     D-Bus display                                : YES
>     QOM debugging                                : YES
>     vhost-kernel support                         : YES
>     vhost-net support                            : YES
>     vhost-user support                           : YES
>     vhost-user-crypto support                    : YES
>     vhost-user-blk server support                : YES
>     vhost-vdpa support                           : YES
>     build guest agent                            : YES
>
>   Compilation
>     host CPU                                     : x86_64
>     host endianness                              : little
>     C compiler                                   : cc -m64 -mcx16
>     Host C compiler                              : cc -m64 -mcx16
>     C++ compiler                                 : NO
>     CFLAGS                                       : -g -O2
>     QEMU_CFLAGS                                  : -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
> -fno-common -fwrapv -fstack-protector-strong -U_FORTIFY_SOURCE
> -D_FORTIFY_SOURCE=2
>     QEMU_LDFLAGS                                 :
> -fstack-protector-strong -Wl,-z,relro -Wl,-z,now -Wl,--warn-common
>     link-time optimization (LTO)                 : NO
>     PIE                                          : YES
>     static build                                 : NO
>     malloc trim support                          : YES
>     membarrier                                   : NO
>     debug graph lock                             : NO
>     debug stack usage                            : NO
>     mutex debugging                              : NO
>     memory allocator                             : system
>     avx2 optimization                            : YES
>     avx512bw optimization                        : YES
>     avx512f optimization                         : NO
>     gprof                                        : NO
>     gcov                                         : NO
>     thread sanitizer                             : NO
>     CFI support                                  : NO
>     strip binaries                               : NO
>     sparse                                       : NO
>     mingw32 support                              : NO
>
>   Cross compilers
>     x86_64                                       : cc
>
>   Targets and accelerators
>     KVM support                                  : YES
>     HVF support                                  : NO
>     WHPX support                                 : NO
>     NVMM support                                 : NO
>     Xen support                                  : NO
>     Xen emulation                                : YES
>     TCG support                                  : YES
>     TCG backend                                  : native (x86_64)
>     TCG plugins                                  : YES
>     TCG debug enabled                            : NO
>     target list                                  : x86_64-softmmu
>     default devices                              : YES
>     out of process emulation                     : YES
>     vfio-user server                             : NO
>
>   Block layer support
>     coroutine backend                            : ucontext
>     coroutine pool                               : YES
>     Block whitelist (rw)                         :
>     Block whitelist (ro)                         :
>     Use block whitelist in tools                 : NO
>     VirtFS (9P) support                          : YES
>     VirtFS (9P) Proxy Helper support (deprecated): YES
>     Live block migration                         : YES
>     replication support                          : YES
>     bochs support                                : YES
>     cloop support                                : YES
>     dmg support                                  : YES
>     qcow v1 support                              : YES
>     vdi support                                  : YES
>     vhdx support                                 : YES
>     vmdk support                                 : YES
>     vpc support                                  : YES
>     vvfat support                                : YES
>     qed support                                  : YES
>     parallels support                            : YES
>     FUSE exports                                 : YES 3.14.1
>     VDUSE block exports                          : YES
>
>   Crypto
>     TLS priority                                 : NORMAL
>     GNUTLS support                               : YES 3.8.1
>       GNUTLS crypto                              : YES
>     libgcrypt                                    : NO
>     nettle                                       : NO
>     AF_ALG support                               : NO
>     rng-none                                     : NO
>     Linux keyring                                : YES
>
>   User interface
>     SDL support                                  : YES 2.26.3
>     SDL image support                            : YES 2.6.3
>     GTK support                                  : YES
>     pixman                                       : YES 0.42.2
>     VTE support                                  : YES 0.72.2
>     PNG support                                  : YES 1.6.37
>     VNC support                                  : YES
>     VNC SASL support                             : YES
>     VNC JPEG support                             : YES 2.1.4
>     spice protocol support                       : YES 0.14.4
>       spice server support                       : YES 0.15.1
>     curses support                               : YES
>     brlapi support                               : YES
>
>   Audio backends
>     OSS support                                  : YES
>     sndio support                                : NO
>     ALSA support                                 : YES 1.2.10
>     PulseAudio support                           : YES 16.1
>     PipeWire support                             : YES 0.3.79
>     JACK support                                 : YES 1.9.17
>
>   Network backends
>     slirp support                                : YES 4.7.0
>     vde support                                  : NO
>     netmap support                               : NO
>     l2tpv3 support                               : YES
>
>   Dependencies
>     libtasn1                                     : YES 4.19.0
>     PAM                                          : YES
>     iconv support                                : YES
>     virgl support                                : YES 0.10.4
>     blkio support                                : YES 1.2.2
>     curl support                                 : YES 8.0.1
>     Multipath support                            : YES
>     Linux AIO support                            : YES
>     Linux io_uring support                       : YES 2.4
>     ATTR/XATTR support                           : YES
>     RDMA support                                 : NO
>     PVRDMA support                               : NO
>     fdt support                                  : system
>     libcap-ng support                            : YES
>     bpf support                                  : YES 1.1.0
>     rbd support                                  : NO
>     smartcard support                            : YES 2.8.1
>     U2F support                                  : NO
>     libusb                                       : YES 1.0.26
>     usb net redir                                : YES 0.13.0
>     OpenGL support (epoxy)                       : YES 1.5.10
>     GBM                                          : YES 23.1.6
>     libiscsi support                             : YES 1.19.0
>     libnfs support                               : YES 4.0.0
>     seccomp support                              : YES 2.5.3
>     GlusterFS support                            : YES 7.11.0
>     TPM support                                  : YES
>     libssh support                               : YES 0.10.5
>     lzo support                                  : YES
>     snappy support                               : YES
>     bzip2 support                                : YES
>     lzfse support                                : NO
>     zstd support                                 : YES 1.5.5
>     NUMA host support                            : NO
>     capstone                                     : YES 4.0.2
>     libpmem support                              : NO
>     libdaxctl support                            : YES 78
>     libudev                                      : YES 253
>     FUSE lseek                                   : YES
>     selinux                                      : YES 3.5
>     libdw                                        : YES 0.189
>
>   Subprojects
>     berkeley-softfloat-3                         : YES
>     berkeley-testfloat-3                         : YES
>     keycodemapdb                                 : YES
>     libvduse                                     : YES
>     libvhost-user                                : YES
>
>   User defined options
>     Native files                                 : config-meson.cross
>     prefix                                       : /usr/local
>     werror                                       : true
>     docs                                         : enabled
>     plugins                                      : true
>
> Stefan


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE989B75C9
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Oct 2024 08:52:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Pyf-0005De-4o; Thu, 31 Oct 2024 03:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6Pya-0005DU-KK
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:52:16 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6PyX-0003aH-Sg
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:52:15 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e49ad46b1so468810b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730361132; x=1730965932;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1gHo7DyUcPqEaAsl8oCYTM1s3Az4DtaIMXl5FebxitM=;
 b=Zrsa0QiRXHAkQCMSURpdvozR+MiAwRxGmda/EPeU+vG+5r+cg4bsAXpamqqN8IRqJf
 tWxQul8DszSxdwclYYpudBYhrICaQwq6JSvSBC3rlaP2ewgHTYNDghuu+TWMDvtygT0W
 IECTFIHDl/sQ+DGlEgSsFxzjXQJpms6sDv8+ujQXXWsaHcJYWhnUDtdmnkFRJxufMgjq
 ifqav4F8X72RerR7fusSSnIqlyBSoaOrz8VkxohNVfTudftHZiNmeRv6bu2R5wFrY4u+
 ZpT7levVoU/4RKP7dMSn3qf9njvPSFO2Da1TDxq+LIpkStThbRcAIghFO21LEMyzXEre
 pFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730361132; x=1730965932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1gHo7DyUcPqEaAsl8oCYTM1s3Az4DtaIMXl5FebxitM=;
 b=lA68CvDxdSZxziJZhUdMS0iywIZo4kWsD1UMIHCuBZYRV7JvAI5h3uXimuJ8zv3fih
 KvytxBNz70v7AijVXeAYHUABTlbtnnEdNpleYADtBRcgMz84oT2X+4zNDq6Q6k2IhvAY
 m//LIU66SEkAvHWDBBWhqoKtqvs8PSYmtkcl6PeFsNTMbAiGpxMRhNC1S2XmOEljWu+O
 TsB9LdqIcWSwWE0BHKbbQv9Sl8B+UZtxzNf/ApOMHhLxhvC0Js/Yvi1NSnExkryF/DKt
 rgrRhzOGjqFS2zRYuhEkPC8Hd1OlrZKMMSTlxX388zburAjdY8pJB1098ZNuRPcsZTfS
 YpDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGlUInRJIVB8TBtDl9SVfNY8/nVXrrMQrAVAKuTrZPlornJ+LAz65FNxQza3o3i0x8fsaUCHuvR/IV@nongnu.org
X-Gm-Message-State: AOJu0YzeS3mxtHLdNyAUIsALHiCEgheTC/UkQbJmefr5RNRFbidwEkUm
 iFJaA/2FUZlQ5jI9QxKXTNlM0Jw0WX1zcT8hK1J2mkJ8QNBesFM56aHlmoTR5TI=
X-Google-Smtp-Source: AGHT+IHvYN8KCWqbRqhjWTZhrYm4k/iNw25Q0CUKIzjUuNaUB5O0zuLrmIUq4elIm86gIwX8XBWerA==
X-Received: by 2002:a05:6a00:4610:b0:71e:4fe4:282e with SMTP id
 d2e1a72fcca58-72063096385mr25652600b3a.28.1730361132071; 
 Thu, 31 Oct 2024 00:52:12 -0700 (PDT)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb6c9sm680875b3a.162.2024.10.31.00.52.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 00:52:11 -0700 (PDT)
Message-ID: <115d6281-65c9-4487-9dfa-26677f9563ec@daynix.com>
Date: Thu, 31 Oct 2024 16:52:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/15] ui & main loop: Redesign of system-specific main
 thread event handling
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20241029205819.69888-1-phil@philjordan.eu>
 <20241029205819.69888-2-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241029205819.69888-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/30 5:58, Phil Dennis-Jordan wrote:
> macOS's Cocoa event handling must be done on the initial (main) thread
> of the process. Furthermore, if library or application code uses
> libdispatch, the main dispatch queue must be handling events on the main
> thread as well.
> 
> So far, this has affected Qemu in both the Cocoa and SDL UIs, although
> in different ways: the Cocoa UI replaces the default qemu_main function
> with one that spins Qemu's internal main event loop off onto a
> background thread. SDL (which uses Cocoa internally) on the other hand
> uses a polling approach within Qemu's main event loop. Events are
> polled during the SDL UI's dpy_refresh callback, which happens to run
> on the main thread by default.
> 
> As UIs are mutually exclusive, this works OK as long as nothing else
> needs platform-native event handling. In the next patch, a new device is
> introduced based on the ParavirtualizedGraphics.framework in macOS.
> This uses libdispatch internally, and only works when events are being
> handled on the main runloop. With the current system, it works when
> using either the Cocoa or the SDL UI. However, it does not when running
> headless. Moreover, any attempt to install a similar scheme to the
> Cocoa UI's main thread replacement fails when combined with the SDL
> UI.
> 
> This change tidies up main thread management to be more flexible.
> 
>   * The qemu_main global function pointer is a custom function for the
>     main thread, and it may now be NULL. When it is, the main thread
>     runs the main Qemu loop. This represents the traditional setup.
>   * When non-null, spawning the main Qemu event loop on a separate
>     thread is now done centrally rather than inside the Cocoa UI code.
>   * For most platforms, qemu_main is indeed NULL by default, but on
>     Darwin, it defaults to a function that runs the CFRunLoop.
>   * The Cocoa UI sets qemu_main to a function which runs the
>     NSApplication event handling runloop, as is usual for a Cocoa app.
>   * The SDL UI overrides the qemu_main function to NULL, thus
>     specifying that Qemu's main loop must run on the main
>     thread.
>   * For other UIs, or in the absence of UIs, the platform's default
>     behaviour is followed.
> 
> This means that on macOS, the platform's runloop events are always
> handled, regardless of chosen UI. The new PV graphics device will
> thus work in all configurations. There is no functional change on other
> operating systems.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
> 
> v5:
> 
>   * Simplified the way of setting/clearing the main loop by going back
>     to setting qemu_main directly, but narrowing the scope of what it
>     needs to do, and it can now be NULL.
> 
>   include/qemu-main.h     |  3 +--
>   include/qemu/typedefs.h |  1 +
>   system/main.c           | 56 +++++++++++++++++++++++++++++++++++----
>   ui/cocoa.m              | 58 +++++++++++------------------------------
>   ui/sdl2.c               |  4 +++
>   5 files changed, 72 insertions(+), 50 deletions(-)
> 
> diff --git a/include/qemu-main.h b/include/qemu-main.h
> index 940960a7dbc..4bd0d667edc 100644
> --- a/include/qemu-main.h
> +++ b/include/qemu-main.h
> @@ -5,7 +5,6 @@
>   #ifndef QEMU_MAIN_H
>   #define QEMU_MAIN_H
>   
> -int qemu_default_main(void);
> -extern int (*qemu_main)(void);
> +extern qemu_main_fn qemu_main;
>   
>   #endif /* QEMU_MAIN_H */
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 3d84efcac47..b02cfe1f328 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
>    * Function types
>    */
>   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
> +typedef int (*qemu_main_fn)(void);
>   
>   #endif /* QEMU_TYPEDEFS_H */
> diff --git a/system/main.c b/system/main.c
> index 9b91d21ea8c..8c90b8d2ddf 100644
> --- a/system/main.c
> +++ b/system/main.c
> @@ -24,13 +24,14 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu-main.h"
> +#include "qemu/main-loop.h"
>   #include "sysemu/sysemu.h"
>   
> -#ifdef CONFIG_SDL
> -#include <SDL.h>
> +#ifdef CONFIG_DARWIN
> +#include <CoreFoundation/CoreFoundation.h>
>   #endif
>   
> -int qemu_default_main(void)
> +static int qemu_default_main(void)
>   {
>       int status;
>   
> @@ -40,10 +41,55 @@ int qemu_default_main(void)
>       return status;
>   }
>   
> -int (*qemu_main)(void) = qemu_default_main;
> +/*
> + * Various macOS system libraries, including the Cocoa UI and anything using
> + * libdispatch, such as ParavirtualizedGraphics.framework, requires that the
> + * main runloop, on the main (initial) thread be running or at least regularly
> + * polled for events. A special mode is therefore supported, where the QEMU
> + * main loop runs on a separate thread and the main thread handles the
> + * CF/Cocoa runloop.
> + */
> +
> +static void *call_qemu_default_main(void *opaque)
> +{
> +    int status;
> +
> +    bql_lock();
> +    status = qemu_default_main();
> +    bql_unlock();
> +
> +    exit(status);
> +}
> +
> +static void qemu_run_default_main_on_new_thread(void)
> +{
> +    QemuThread thread;
> +
> +    qemu_thread_create(&thread, "qemu_main", call_qemu_default_main,
> +                       NULL, QEMU_THREAD_DETACHED);

This function only contains two statements and I think is better to be 
merged into main().

> +}
> +
> +
> +#ifdef CONFIG_DARWIN
> +static int os_darwin_cfrunloop_main(void)
> +{
> +    CFRunLoopRun();
> +    abort();
> +}
> +
> +qemu_main_fn qemu_main = os_darwin_cfrunloop_main;
> +#else
> +qemu_main_fn qemu_main;
> +#endif
>   
>   int main(int argc, char **argv)
>   {
>       qemu_init(argc, argv);
> -    return qemu_main();
> +    if (qemu_main) {
> +        qemu_run_default_main_on_new_thread();
> +        bql_unlock();
> +        return qemu_main();
> +    } else {
> +        qemu_default_main();
> +    }
>   }
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 4c2dd335323..a1474d473a6 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -73,6 +73,8 @@
>       int height;
>   } QEMUScreen;
>   
> +@class QemuCocoaPasteboardTypeOwner;
> +
>   static void cocoa_update(DisplayChangeListener *dcl,
>                            int x, int y, int w, int h);
>   
> @@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
>   static NSInteger cbchangecount = -1;
>   static QemuClipboardInfo *cbinfo;
>   static QemuEvent cbevent;
> +static QemuCocoaPasteboardTypeOwner *cbowner;
>   
>   // Utility functions to run specified code block with the BQL held
>   typedef void (^CodeBlock)(void);
> @@ -1321,8 +1324,10 @@ - (void) dealloc
>   {
>       COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
>   
> -    if (cocoaView)
> -        [cocoaView release];
> +    [cocoaView release];
> +    [cbowner release];
> +    cbowner = nil;
> +
>       [super dealloc];
>   }
>   
> @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender provideDataForType:(NSPasteboardType)t
>   
>   @end
>   
> -static QemuCocoaPasteboardTypeOwner *cbowner;
> -
>   static void cocoa_clipboard_notify(Notifier *notifier, void *data);
>   static void cocoa_clipboard_request(QemuClipboardInfo *info,
>                                       QemuClipboardType type);
> @@ -2002,43 +2005,8 @@ static void cocoa_clipboard_request(QemuClipboardInfo *info,
>       }
>   }
>   
> -/*
> - * The startup process for the OSX/Cocoa UI is complicated, because
> - * OSX insists that the UI runs on the initial main thread, and so we
> - * need to start a second thread which runs the qemu_default_main():
> - * in main():
> - *  in cocoa_display_init():
> - *   assign cocoa_main to qemu_main
> - *   create application, menus, etc
> - *  in cocoa_main():
> - *   create qemu-main thread
> - *   enter OSX run loop
> - */
> -
> -static void *call_qemu_main(void *opaque)
> -{
> -    int status;
> -
> -    COCOA_DEBUG("Second thread: calling qemu_default_main()\n");
> -    bql_lock();
> -    status = qemu_default_main();
> -    bql_unlock();
> -    COCOA_DEBUG("Second thread: qemu_default_main() returned, exiting\n");
> -    [cbowner release];
> -    exit(status);
> -}
> -
>   static int cocoa_main(void)
>   {
> -    QemuThread thread;
> -
> -    COCOA_DEBUG("Entered %s()\n", __func__);
> -
> -    bql_unlock();
> -    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
> -                       NULL, QEMU_THREAD_DETACHED);
> -
> -    // Start the main event loop
>       COCOA_DEBUG("Main thread: entering OSX run loop\n");
>       [NSApp run];
>       COCOA_DEBUG("Main thread: left OSX run loop, which should never happen\n");
> @@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>   
>       COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
>   
> -    qemu_main = cocoa_main;
> -
>       // Pull this console process up to being a fully-fledged graphical
>       // app with a menubar and Dock icon
>       ProcessSerialNumber psn = { 0, kCurrentProcess };
> @@ -2185,11 +2151,17 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>       qemu_clipboard_peer_register(&cbpeer);
>   
>       [pool release];
> +
> +    /*
> +     * The Cocoa UI will run the NSApplication runloop on the main thread
> +     * rather than the default Core Foundation one.
> +     */
> +    qemu_main = cocoa_main;
>   }
>   
>   static QemuDisplay qemu_display_cocoa = {
> -    .type       = DISPLAY_TYPE_COCOA,
> -    .init       = cocoa_display_init,
> +    .type                   = DISPLAY_TYPE_COCOA,
> +    .init                   = cocoa_display_init,

This change seems irrelevant.

>   };
>   
>   static void register_cocoa(void)
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index bd4f5a9da14..44ab2762262 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -34,6 +34,7 @@
>   #include "sysemu/sysemu.h"
>   #include "ui/win32-kbd-hook.h"
>   #include "qemu/log.h"
> +#include "qemu-main.h"
>   
>   static int sdl2_num_outputs;
>   static struct sdl2_console *sdl2_console;
> @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>       }
>   
>       atexit(sdl_cleanup);
> +
> +    /* SDL's event polling (in dpy_refresh) must happen on the main thread. */
> +    qemu_main = NULL;
>   }
>   
>   static QemuDisplay qemu_display_sdl2 = {



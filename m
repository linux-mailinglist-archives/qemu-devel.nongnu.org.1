Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 097219D5903
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Nov 2024 06:03:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tELoN-0004qM-P5; Fri, 22 Nov 2024 00:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELoF-0004pk-Rt
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:02:23 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELoB-0006Nd-QG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:02:22 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-296c237a121so1114518fac.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 21:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732251737; x=1732856537;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p8eRtnHTFdUK6JH38yoNL3qr++02oV60vh90qEZTfb4=;
 b=iGtqeZ9xiDm69MM0YfuJ5LCzCESw4w8XIRL8FSkgPVencomf9Yy6OYO8Jmbde2OTQc
 1/rIvGxceE3BRxfgWoS/S8niL8K1+IlSnMr3t95R2BH/Vow50Sv7ra0nhK0V+iuc+53L
 UlaIzU08LwQ3TkWilJwoYIZt4eadJXJE4EXXzYwREZSoHz4ikYpbEM+Rn09EgOj5DQkE
 MCv19Rck3yA4Uili5x1cqB+OmHeg/07Cn5/KE8J1lH4ofrpm6Ofh1jvYBv9c1oK6XO9T
 8YdOrM7Q6GdYtbzOtsujOw60MZvvn24Hryixf6zRgGohVXULHftpbiCwBy5ht5YyJ45M
 5awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732251737; x=1732856537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p8eRtnHTFdUK6JH38yoNL3qr++02oV60vh90qEZTfb4=;
 b=oLYCrPDMArMb9lkd0NRmdxzi4+ZghPlIBwBxoEjuvSI6E6c1pO0pu6COVu630BEAUz
 muIczitXgRgSKNRDUkmVDUzKZ4DW87MDpB0y9EPffI6Aookxs/Zbp4nB8pvNXGbNUjfY
 xkFhypj+W6sIggN2c0oPtNXkFtJucV73wiY2oqHWV42VQl7PgYPNc3IpfzEc6+aWWfik
 2rPKK6jZe48gGGg+KtLMqdq6o8XqQwkXGXpgZNSC7t1Mv/n8B+E7p3HTsWosJgqvVS3V
 ByXB2tJ97VCk4QNdMOROmyyUj/mPKPwTrZHlMHkbYQnU7sky8ihojlELrHIZudPGNWRq
 zEMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmxvqnMVzX3j3UicyCeJJ4BTQUAJqUfVOzWm6152NG/LGmemO2PjeNF/ehRwQP/PfMkJ625Sxaba+x@nongnu.org
X-Gm-Message-State: AOJu0Yzcxym2FuqcIz4TvcIijrOuIR1TWCg3uJs7QhbmnL59JBX0THUr
 68YMD0lIqxGKFMM9b37WH4Zr1QNcGovh1wrzzIyaZFixQLsS6nEl1SR8l9Z7LwM=
X-Gm-Gg: ASbGncuYtwzGbNaJP1467Aoy2c/xS4V89+ddfJZTOPYvJ8LLuW1unYM57RTodXOZifC
 ccnoc8lc3jAzGO3uSDt2isCzXnNKxMCgvP4RnllN5BsT+LSNj3BygywE5CGfJ1+VhsALhrvCjSM
 ugmBIb86SXk//2AhAAXafAGtpXhifFFtM0XPaOIa6zhrsyqmXzsQMf4Exxh4trzdWtdaoICobpC
 nbW2Y2cNejFPikZz8jIttuAZ1TLxSlfb8EOsx6QHbFBm5ibKGqPUpRhYsiZriA=
X-Google-Smtp-Source: AGHT+IHHxuN/LqHH44Lnl4wMddP+/VinjycPIRu5RdvBuYy7JHsQD8BtI9NQ0sPfk2OCje8jHA4eww==
X-Received: by 2002:a05:6870:1b18:b0:295:eb24:71cf with SMTP id
 586e51a60fabf-29720b45f28mr1973581fac.2.1732251736877; 
 Thu, 21 Nov 2024 21:02:16 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f0698798e1sm262050eaf.41.2024.11.21.21.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 21:02:16 -0800 (PST)
Message-ID: <4ff6f75f-eece-4c78-9701-fc190e483f4e@daynix.com>
Date: Fri, 22 Nov 2024 14:02:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241113142343.40832-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/11/13 23:23, Phil Dennis-Jordan wrote:
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
>   * The GTK UI also overrides the qemu_main function to NULL.
>   * For other UIs, or in the absence of UIs, the platform's default
>     behaviour is followed.
> 
> This means that on macOS, the platform's runloop events are always
> handled, regardless of chosen UI. The new PV graphics device will
> thus work in all configurations. There is no functional change on other
> operating systems.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> 
> v5:
> 
>   * Simplified the way of setting/clearing the main loop by going back
>     to setting qemu_main directly, but narrowing the scope of what it
>     needs to do, and it can now be NULL.
> 
> v6:
> 
>   * Folded function qemu_run_default_main_on_new_thread's code into
>     main()
>   * Removed whitespace changes left over on lines near code removed
>     between v4 and v5
> 
> v9:
> 
>   * Set qemu_main to NULL for GTK UI as well.
> 
> v10:
> 
>   * Added comments clarifying the functionality and purpose of qemu_main.
> 
>   include/qemu-main.h     | 21 ++++++++++++++--
>   include/qemu/typedefs.h |  1 +
>   system/main.c           | 50 ++++++++++++++++++++++++++++++++++----
>   ui/cocoa.m              | 54 ++++++++++-------------------------------
>   ui/gtk.c                |  8 ++++++
>   ui/sdl2.c               |  4 +++
>   6 files changed, 90 insertions(+), 48 deletions(-)
> 
> diff --git a/include/qemu-main.h b/include/qemu-main.h
> index 940960a7dbc..fc70681c8b5 100644
> --- a/include/qemu-main.h
> +++ b/include/qemu-main.h
> @@ -5,7 +5,24 @@
>   #ifndef QEMU_MAIN_H
>   #define QEMU_MAIN_H
>   
> -int qemu_default_main(void);
> -extern int (*qemu_main)(void);
> +/*
> + * The function to run on the main (initial) thread of the process.
> + * NULL means QEMU's main event loop.
> + * When non-NULL, QEMU's main event loop will run on a purposely created
> + * thread, after which the provided function pointer will be invoked on
> + * the initial thread.
> + * This is useful on platforms which treat the main thread as special
> + * (macOS/Darwin) and/or require all UI API calls to occur from a
> + * specific thread.
> + * Implementing this via a global function pointer variable is a bit
> + * ugly, but it's probably worth investigating the existing UI thread rule
> + * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
> + * issues might precipitate requirements similar but not identical to those
> + * of the Cocoa UI; hopefully we'll see some kind of pattern emerge, which
> + * can then be used as a basis for an overhaul. (In fact, it may turn
> + * out to be simplest to split the UI/native platform event thread from the
> + * QEMU main event loop on all platforms, with any UI or even none at all.)
> + */
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
> index 9b91d21ea8c..d9397a6d5d0 100644
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

I found dropping these lines prevent building for Windows. This is 
because pkg-config of sdl2 redefines main() as SDL_main(), and GCC complains
-Wmissing-prototypes for SDL_main(). Here is a link to the relevant code 
in SDL2:
https://github.com/libsdl-org/SDL/blob/release-2.30.9/CMakeLists.txt#L2061

> +#ifdef CONFIG_DARWIN
> +#include <CoreFoundation/CoreFoundation.h>
>   #endif
>   
> -int qemu_default_main(void)
> +static int qemu_default_main(void)
>   {
>       int status;
>   
> @@ -40,10 +41,49 @@ int qemu_default_main(void)
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
> +    QemuThread main_loop_thread;
> +
>       qemu_init(argc, argv);
> -    return qemu_main();
> +    if (qemu_main) {
> +        qemu_thread_create(&main_loop_thread, "qemu_main",
> +                           call_qemu_default_main, NULL, QEMU_THREAD_DETACHED);
> +        bql_unlock();
> +        return qemu_main();
> +    } else {
> +        qemu_default_main();
> +    }
>   }
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 4c2dd335323..30b8920d929 100644
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
> @@ -2185,6 +2151,12 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
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
> diff --git a/ui/gtk.c b/ui/gtk.c
> index bf9d3dd679a..fbf20161f36 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -38,6 +38,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
> +#include "qemu-main.h"
>   
>   #include "ui/console.h"
>   #include "ui/gtk.h"
> @@ -2485,6 +2486,13 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>   #ifdef CONFIG_GTK_CLIPBOARD
>       gd_clipboard_init(s);
>   #endif /* CONFIG_GTK_CLIPBOARD */
> +
> +    /*
> +     * GTK+ calls must happen on the main thread at least on some platforms,
> +     * and on macOS the main runloop is polled via GTK+'s event handling.
> +     * Don't allow QEMU's event loop to be moved off the main thread.
> +     */
> +    qemu_main = NULL;
>   }
>   
>   static void early_gtk_display_init(DisplayOptions *opts)
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D9AD25A6
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Jun 2025 20:32:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhHM-00031T-QE; Mon, 09 Jun 2025 14:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uOhHD-00031C-9b
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:31:20 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uOhH8-0004W3-TA
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:31:18 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8436955BC02;
 Mon, 09 Jun 2025 20:31:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 9_0yeTSgeMpY; Mon,  9 Jun 2025 20:31:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7CD2855BC03; Mon, 09 Jun 2025 20:31:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7A847745682;
 Mon, 09 Jun 2025 20:31:02 +0200 (CEST)
Date: Mon, 9 Jun 2025 20:31:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Tanish Desai <tanishdesai37@gmail.com>
cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@gmail.com, 
 mads@ynddal.dk, philmd@linaro.org, peter.maydell@linaro.org
Subject: Re: [PATCH] utils/log: add qemu_log_timestamp() to encapsulate
 timestamp logging
In-Reply-To: <20250609182044.21703-1-tanishdesai37@gmail.com>
Message-ID: <36063c9f-f1f6-f4f7-8be5-735694a7f8c9@eik.bme.hu>
References: <20250609182044.21703-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 9 Jun 2025, Tanish Desai wrote:
> Moved the logic for timestamped logging (~6 lines) from a_nocheck__trace_foo(header) into a new qemu_log_timestamp() function in util/log.c. This avoids code duplication across binaries and enables reuse as a standalone utility.
> Encapsulation helps reduce build size significantly, particularly when many trace points are present. On Ubuntu 22 with
> ./configure --target-list=aarch64-softmmu --enable-kvm --enable-trace-backends=log,
> this change reduced the build directory size from ~1435.27 MB to ~1412 MB (~23 MB saved).
> Notable reductions include:
>    trace/: ~2.6 MB
>    libqemuutil.a.p: ~3 MB
> A detailed report of size changes (in bytes) for relevant folders and subfolders will follow in a trailing mail.

I think this is inline to avoid overhead of function call at runtime when 
logging is not enabled which is more important than saving build time or 
disk space but I could be wrong.

Regards,
BALATON Zoltan

> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
> include/qemu/log-for-trace.h     |  3 +++
> scripts/tracetool/backend/log.py | 13 +------------
> util/log.c                       | 18 ++++++++++++++++++
> 3 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> index d47c9cd446..680f30a8a9 100644
> --- a/include/qemu/log-for-trace.h
> +++ b/include/qemu/log-for-trace.h
> @@ -32,4 +32,7 @@ static inline bool qemu_loglevel_mask(int mask)
> /* main logging function */
> void G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
>
> +/* main logging function with timestamp */
> +void G_GNUC_PRINTF(1, 2) qemu_log_timestamp(const char *fmt, ...);
> +
> #endif
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
> index de27b7e62e..3358afb43a 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -38,20 +38,9 @@ def generate_h(event, group):
>         cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
>
>     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> -        '        if (message_with_timestamp) {',
> -        '            struct timeval _now;',
> -        '            gettimeofday(&_now, NULL);',
>         '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
> -        '                     qemu_get_thread_id(),',
> -        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
> -        '                     %(argnames)s);',
> +        '            qemu_log_timestamp("%(name)s " %(fmt)s "\\n"%(argnames)s);',
>         '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '        } else {',
> -        '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
> -        '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '        }',
>         '    }',
>         cond=cond,
>         event_lineno=event.lineno,
> diff --git a/util/log.c b/util/log.c
> index b87d399e4c..996530fe7e 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -143,6 +143,24 @@ void qemu_log_unlock(FILE *logfile)
>     }
> }
>
> +
> +void qemu_log_timestamp(const char *fmt, ...)
> +{
> +    FILE *f = qemu_log_trylock();
> +    if (f) {
> +        va_list ap;
> +        if(message_with_timestamp){
> +            struct timeval _now;
> +            gettimeofday(&_now, NULL);
> +            fprintf(f,"%d@%zu.%06zu:",qemu_get_thread_id(),(size_t)_now.tv_sec, (size_t)_now.tv_usec);
> +        }
> +        va_start(ap, fmt);
> +        vfprintf(f, fmt, ap);
> +        va_end(ap);
> +    }
> +    qemu_log_unlock(f);
> +}
> +
> void qemu_log(const char *fmt, ...)
> {
>     FILE *f = qemu_log_trylock();
>


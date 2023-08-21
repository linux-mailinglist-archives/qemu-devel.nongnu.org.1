Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C67D782542
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 10:18:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY05s-0001cL-44; Mon, 21 Aug 2023 04:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qY05o-0001c1-4i
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:16:56 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qY05l-0006vg-PX
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:16:55 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5007c8308c3so1333274e87.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 01:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692605811; x=1693210611;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhwxeqshD7fzJd+qQ6N069xlL0fmdKj5A4NzzwjtbfQ=;
 b=WR+1X932yFaNSzTXB5mopXHHPq0gDAdL9/ISkPe21AF9wh0kN1qXQw/GojGLPpqhg6
 YsatK9TDuQIYbu30zzm7QlWad2geTIMW+1GC4IlE+pEWf41IPx/wpYpUZGginS2oBK2i
 9JyoFTcPiz+UeFB4O/MfUmqcZX45kPbMKBx0Gk1qw7BIGEEtn7zxpIYL2pn04Ynno11T
 aFUv20hoSBGIBmYrpKZXMqMRIFyNBjE78ArHp70IqbVARNAk0J7iUll+JssWU8B2JOmi
 0HbuwrZdXTZ3pRsWvdVXctgz0fcmjSCo7cPqjhAlaiiN3KkQQB96pMUBnl2Ix4sZ+Rzs
 JQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692605811; x=1693210611;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhwxeqshD7fzJd+qQ6N069xlL0fmdKj5A4NzzwjtbfQ=;
 b=NC4OQhIwubLWstm13gkvF3texOXlu7cWhrF2A6vvVKjxbIkcJ+GxT3srDhAUaz1kKL
 7kTMr36S21UT7a1PcYMD0vmdQzjYAsCfukU7qPsHMCaB+aNcgZQQJoephT56QMTk0ueF
 Sdt0fhMAUu8DW6wuR+8OhJCzHU3G3qAqiMV3UtogZe3u0gc6Mu/yTJF2tnbhirJKEDAa
 em/gz6vGGmC4Dmprwr+1f1EGL/Qr/Zom9rKnulk43kP+7HOSoxdieZNyW94K/h6JA0MS
 8fLrQwKRBRQ86YEV/UHVewm/2o39rzctv2Dr1119AJSwwW7HAmqxRElAUKYimYcoC6vk
 zhWQ==
X-Gm-Message-State: AOJu0Yw94UVbmbBuBsnfguJVgoE6f5PLNL8bRDnsEqwkQM+7lNKA7mjj
 WKLnTyBdPbtNId87UDky7s8=
X-Google-Smtp-Source: AGHT+IH6UKgW6VGsgnhPd2ir9XGLGHdHqZ9QvWv6cR6qjoSXtXVsCOF0kPrRyEgDDQPfZ3VXnuM2tA==
X-Received: by 2002:a05:6512:3c89:b0:4fb:7666:3bc0 with SMTP id
 h9-20020a0565123c8900b004fb76663bc0mr5446102lfv.47.1692605811008; 
 Mon, 21 Aug 2023 01:16:51 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 b11-20020ac247eb000000b004fddb0eb961sm1645321lfp.18.2023.08.21.01.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 01:16:50 -0700 (PDT)
Date: Mon, 21 Aug 2023 10:16:49 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 2/2] audio/jackaudio: Avoid dynamic stack allocation in
 qjack_process()
Message-ID: <20230821081648.GN6984@fralle-msi>
References: <20230818155846.1651287-1-peter.maydell@linaro.org>
 <20230818155846.1651287-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818155846.1651287-3-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

On [2023 Aug 18] Fri 16:58:46, Peter Maydell wrote:
> Avoid a dynamic stack allocation in qjack_process().  Since this
> function is a JACK process callback, we are not permitted to malloc()
> here, so we allocate a working buffer in qjack_client_init() instead.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
> This feels like we ought to be able to say "we know there are at most
> X channels, so allocate an array of size X on the stack", but I
> couldn't find anything in the audio subsystem from a quick look that
> set an obvious bound on the number of channels.  Is there some
> straightforward constant MAX_CHANNELS somewhere?
> ---
>  audio/jackaudio.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 7cb2a49f971..e1eaa3477dc 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -70,6 +70,9 @@ typedef struct QJackClient {
>      int             buffersize;
>      jack_port_t   **port;
>      QJackBuffer     fifo;
> +
> +    /* Used as workspace by qjack_process() */
> +    float **process_buffers;
>  }
>  QJackClient;
>  
> @@ -267,22 +270,21 @@ static int qjack_process(jack_nframes_t nframes, void *arg)
>      }
>  
>      /* get the buffers for the ports */
> -    float *buffers[c->nchannels];
>      for (int i = 0; i < c->nchannels; ++i) {
> -        buffers[i] = jack_port_get_buffer(c->port[i], nframes);
> +        c->process_buffers[i] = jack_port_get_buffer(c->port[i], nframes);
>      }
>  
>      if (c->out) {
>          if (likely(c->enabled)) {
> -            qjack_buffer_read_l(&c->fifo, buffers, nframes);
> +            qjack_buffer_read_l(&c->fifo, c->process_buffers, nframes);
>          } else {
>              for (int i = 0; i < c->nchannels; ++i) {
> -                memset(buffers[i], 0, nframes * sizeof(float));
> +                memset(c->process_buffers[i], 0, nframes * sizeof(float));
>              }
>          }
>      } else {
>          if (likely(c->enabled)) {
> -            qjack_buffer_write_l(&c->fifo, buffers, nframes);
> +            qjack_buffer_write_l(&c->fifo, c->process_buffers, nframes);
>          }
>      }
>  
> @@ -448,6 +450,9 @@ static int qjack_client_init(QJackClient *c)
>            jack_get_client_name(c->client));
>      }
>  
> +    /* Allocate working buffer for process callback */
> +    c->process_buffers = g_new(float *, c->nchannels);
> +
>      jack_set_process_callback(c->client, qjack_process , c);
>      jack_set_port_registration_callback(c->client, qjack_port_registration, c);
>      jack_set_xrun_callback(c->client, qjack_xrun, c);
> @@ -579,6 +584,7 @@ static void qjack_client_fini_locked(QJackClient *c)
>  
>          qjack_buffer_free(&c->fifo);
>          g_free(c->port);
> +        g_free(c->process_buffers);
>  
>          c->state = QJACK_STATE_DISCONNECTED;
>          /* fallthrough */
> -- 
> 2.34.1
> 
> 


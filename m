Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF678429D
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRsN-0002zm-V7; Tue, 22 Aug 2023 09:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qYRs7-0002yQ-1P
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:56:39 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qYRs4-0001ZO-G3
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=4H6fA1oQeAH1EsfK7udq9VUvpmss/oGOMd2BF338m88=; b=U2dQTu8BshOxiK8LWUhm9yxrTp
 Lk69C6feyoTAm5yKSx964Vm/qAW4dcpu7+AkBAiMoGDgQT8wZGxnQTHOEY6pDAx/kUTj5BkBhnEQZ
 OnAgqeifRfBsZ/SLQtFWpMu+SsQS952C9myTJTjJ+HQy1sKFWmAOaQAgMG3D9yxx/K5lU9YhF8yIF
 XtjR6yt6Lngnk77uC166444DETxAqNgu/Yy9rACJduuCtKxfm+pqWi3bO6ed/JmucSMnRwnyKcbcZ
 gqyNgD/QcXtoNk/sG/vBJRwuoZobzE5J/2A60djDYygy0d486mKGl8nilRtzjywCjUS/LWXAzSz5R
 7M8arKi4aAcPVZq97lWLBBWxQzHUQBA4W7D3Y81Rb6nUaYmz1bC+v/lafGdGXEEACX+5LOwQKyswO
 vXpG0iQTPCbA9X8YgLoWNSUGaQyEESpB9mdzsV48FS1DFPWweE10WC2jdmTJEUQZ4lCaUKWG4uha0
 I+/q1L2vgSCt/Apsfouu6ykFyiufPyj5ilZk8bQqeuw9DH75m1ntivEEZUrH+Y2oD5Ba7EvqyszIF
 W8ziFhQ02SKFJ392LCDYT8cYv7c3LD6bOYynT+/n5reymYDTUAfu2Honc+q54bNVxH2H3wGQWSWjC
 zcw9CJ7ZyrUdW8rY2t6n4CJsZ3E5ZzldlAz20t4XY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] audio/jackaudio: Avoid dynamic stack allocation in
 qjack_process()
Date: Tue, 22 Aug 2023 15:56:31 +0200
Message-ID: <1702669.g6eAV7DQBD@silver>
In-Reply-To: <20230818155846.1651287-3-peter.maydell@linaro.org>
References: <20230818155846.1651287-1-peter.maydell@linaro.org>
 <20230818155846.1651287-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Friday, August 18, 2023 5:58:46 PM CEST Peter Maydell wrote:
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
> ---
> This feels like we ought to be able to say "we know there are at most
> X channels, so allocate an array of size X on the stack", but I
> couldn't find anything in the audio subsystem from a quick look that
> set an obvious bound on the number of channels.  Is there some
> straightforward constant MAX_CHANNELS somewhere?
> ---

The JACK API doesn't have an official limit on "ports", but AFAICS in QEMU
there is a limit of max. 16 audio channels for audio frontends.

The QEMU `channels` CL option is apparently not limited ATM, but it might make
sense to limit that option to 16 channels as well. I mean anything beyond 16th
channel was a dead channel anyway, right?

Probably a separate battle field though:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

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
> 




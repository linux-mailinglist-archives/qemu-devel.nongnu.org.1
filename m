Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAB67A5A25
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 08:48:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUWj-0007KH-Gl; Tue, 19 Sep 2023 02:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qiUWW-0007K0-6B
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:47:52 -0400
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qiUWT-0004iP-HX
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:47:51 -0400
Received: from fwd84.aul.t-online.de (fwd84.aul.t-online.de [10.223.144.110])
 by mailout05.t-online.de (Postfix) with SMTP id CD9C82D3;
 Tue, 19 Sep 2023 08:47:36 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.31.195]) by fwd84.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qiUWE-0vqrwn0; Tue, 19 Sep 2023 08:47:34 +0200
Content-Type: multipart/alternative;
 boundary="------------k8W6vRCb0TP1zwrZFsmTHjCm"
Message-ID: <24b03552-7ac4-442d-b9c0-75ad9dd1d0c6@t-online.de>
Date: Tue, 19 Sep 2023 08:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/12] virtio-sound: implement audio capture (RX)
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
 <9dd07311d79840ffcfaede03b425ba0b096f3961.1694588927.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <9dd07311d79840ffcfaede03b425ba0b096f3961.1694588927.git.manos.pitsidianakis@linaro.org>
X-TOI-EXPURGATEID: 150726::1695106054-0BFFC649-366557DB/0/0 CLEAN NORMAL
X-TOI-MSGID: 01307616-f03a-4ab5-8302-7d98756a0f30
Received-SPF: none client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------k8W6vRCb0TP1zwrZFsmTHjCm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.09.23 um 09:33 schrieb Emmanouil Pitsidianakis:
> To perform audio capture we duplicate the TX logic of the previous
> commit with the following difference: we receive data from the QEMU
> audio backend and write it in the virt queue IO buffers the guest sends
> to QEMU. When they are full (i.e. they have `period_bytes` amount of
> data) or when recording stops in QEMU's audio backend, the buffer is
> returned to the guest by notifying it.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/virtio/trace-events |   3 +-
>  hw/virtio/virtio-snd.c | 233 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 213 insertions(+), 23 deletions(-)

> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
> index 6fe03f9790..1d3a001371 100644
> --- a/hw/virtio/virtio-snd.c
> +++ b/hw/virtio/virtio-snd.c
> @@ -1048,26 +1131,133 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
>  }
>  
>  /*
> - * Flush all buffer data from this stream's queue into the driver's virtual
> - * queue.
> + * AUD_* input callback.
>   *
> - * @stream: VirtIOSoundPCMStream *stream
> + * @data: VirtIOSoundPCMStream stream
> + * @available: number of bytes that can be read with AUD_read()
>   */
> -static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
> +static void virtio_snd_pcm_in_cb(void *data, int available)
>  {
> +    VirtIOSoundPCMStream *stream = data;
>      VirtIOSoundPCMBlock *block;
> -    VirtIOSoundPCMBlock *next;
> +    virtio_snd_pcm_status resp = { 0 };
> +    size_t size;
>  
>      WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
> -            AUD_write(stream->voice.out, block->data + block->offset, block->size);
> -            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
> -            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
> -            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
> +        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
> +            block = QSIMPLEQ_FIRST(&stream->queue);
> +
> +            for (;;) {
> +                size = AUD_read(stream->voice.in,
> +                        block->data + block->size,
> +                        MIN(available, (stream->params.period_bytes - block->size)));
> +                if (!size) {
> +                    available = 0;
> +                    break;
> +                }
> +                block->size += size;
> +                available -= size;
> +                if (block->size >= stream->params.period_bytes) {
> +                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
> +                    resp.latency_bytes = 0;
> +                    /* Copy data -if any- to guest */
> +                    iov_from_buf(block->elem->in_sg,
> +                                 block->elem->in_num,
> +                                 0,
> +                                 block->data,
> +                                 stream->params.period_bytes);
> +                    iov_from_buf(block->elem->in_sg,
> +                                 block->elem->in_num,
> +                                 block->size,
> +                                 &resp,
> +                                 sizeof(resp));
> +                    virtqueue_push(block->vq,
> +                                   block->elem,
> +                                   sizeof(block->elem));

Hi Manos,

if I'm not completely mistaken, the third argument of a virtqueue_push()
call is the size of the message copied into the virtio ring buffer, not
the size of a pointer. As I wrote for the v8 series, the other
virtqueue_push() calls also don't look right.

With best regards,
Volker

> +                    virtio_notify(VIRTIO_DEVICE(stream->s),
> +                                  block->vq);
> +                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
> +                    virtio_snd_pcm_block_free(block);
> +                    break;
> +                }
> +                if (!available) {
> +                    break;
> +                }
> +            }
> +            if (!available) {
> +                break;
> +            }
>          }
>      }
>  }
>
--------------k8W6vRCb0TP1zwrZFsmTHjCm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 13.09.23 um 09:33 schrieb Emmanouil
      Pitsidianakis:<br>
    </div>
    <blockquote type="cite"
cite="mid:9dd07311d79840ffcfaede03b425ba0b096f3961.1694588927.git.manos.pitsidianakis@linaro.org">
      <pre class="moz-quote-pre" wrap="">To perform audio capture we duplicate the TX logic of the previous
commit with the following difference: we receive data from the QEMU
audio backend and write it in the virt queue IO buffers the guest sends
to QEMU. When they are full (i.e. they have `period_bytes` amount of
data) or when recording stops in QEMU's audio backend, the buffer is
returned to the guest by notifying it.

Signed-off-by: Emmanouil Pitsidianakis <a class="moz-txt-link-rfc2396E" href="mailto:manos.pitsidianakis@linaro.org">&lt;manos.pitsidianakis@linaro.org&gt;</a>
---
 hw/virtio/trace-events |   3 +-
 hw/virtio/virtio-snd.c | 233 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 213 insertions(+), 23 deletions(-)
</pre>
    </blockquote>
    <br>
    <blockquote type="cite"
cite="mid:9dd07311d79840ffcfaede03b425ba0b096f3961.1694588927.git.manos.pitsidianakis@linaro.org">
      <pre class="moz-quote-pre" wrap="">diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 6fe03f9790..1d3a001371 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -1048,26 +1131,133 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
 }
 
 /*
- * Flush all buffer data from this stream's queue into the driver's virtual
- * queue.
+ * AUD_* input callback.
  *
- * @stream: VirtIOSoundPCMStream *stream
+ * @data: VirtIOSoundPCMStream stream
+ * @available: number of bytes that can be read with AUD_read()
  */
-static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
+static void virtio_snd_pcm_in_cb(void *data, int available)
 {
+    VirtIOSoundPCMStream *stream = data;
     VirtIOSoundPCMBlock *block;
-    VirtIOSoundPCMBlock *next;
+    virtio_snd_pcm_status resp = { 0 };
+    size_t size;
 
     WITH_QEMU_LOCK_GUARD(&amp;stream-&gt;queue_mutex) {
-        QSIMPLEQ_FOREACH_SAFE(block, &amp;stream-&gt;queue, entry, next) {
-            AUD_write(stream-&gt;voice.out, block-&gt;data + block-&gt;offset, block-&gt;size);
-            virtqueue_push(block-&gt;vq, block-&gt;elem, sizeof(block-&gt;elem));
-            virtio_notify(VIRTIO_DEVICE(stream-&gt;s), block-&gt;vq);
-            QSIMPLEQ_REMOVE(&amp;stream-&gt;queue, block, VirtIOSoundPCMBlock, entry);
+        while (!QSIMPLEQ_EMPTY(&amp;stream-&gt;queue)) {
+            block = QSIMPLEQ_FIRST(&amp;stream-&gt;queue);
+
+            for (;;) {
+                size = AUD_read(stream-&gt;voice.in,
+                        block-&gt;data + block-&gt;size,
+                        MIN(available, (stream-&gt;params.period_bytes - block-&gt;size)));
+                if (!size) {
+                    available = 0;
+                    break;
+                }
+                block-&gt;size += size;
+                available -= size;
+                if (block-&gt;size &gt;= stream-&gt;params.period_bytes) {
+                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
+                    resp.latency_bytes = 0;
+                    /* Copy data -if any- to guest */
+                    iov_from_buf(block-&gt;elem-&gt;in_sg,
+                                 block-&gt;elem-&gt;in_num,
+                                 0,
+                                 block-&gt;data,
+                                 stream-&gt;params.period_bytes);
+                    iov_from_buf(block-&gt;elem-&gt;in_sg,
+                                 block-&gt;elem-&gt;in_num,
+                                 block-&gt;size,
+                                 &amp;resp,
+                                 sizeof(resp));
+                    virtqueue_push(block-&gt;vq,
+                                   block-&gt;elem,
+                                   sizeof(block-&gt;elem));</pre>
    </blockquote>
    <br>
    Hi Manos,<br>
    <br>
    <span _d-id="30957" class="--l --r sentence_highlight">if I'm not
      completely mistaken, the third argument of a virtqueue_push() call
      is the size of the message copied into the virtio ring buffer, not
      the size of a pointer. As I wrote for the v8 series, </span>the
    other virtqueue_push() calls also don't look right.<br>
    <br>
    With best regards,<br>
    Volker<br>
    <br>
    <blockquote type="cite"
cite="mid:9dd07311d79840ffcfaede03b425ba0b096f3961.1694588927.git.manos.pitsidianakis@linaro.org">
      <pre class="moz-quote-pre" wrap="">
+                    virtio_notify(VIRTIO_DEVICE(stream-&gt;s),
+                                  block-&gt;vq);
+                    QSIMPLEQ_REMOVE_HEAD(&amp;stream-&gt;queue, entry);
+                    virtio_snd_pcm_block_free(block);
+                    break;
+                }
+                if (!available) {
+                    break;
+                }
+            }
+            if (!available) {
+                break;
+            }
         }
     }
 }

</pre>
    </blockquote>
  </body>
</html>

--------------k8W6vRCb0TP1zwrZFsmTHjCm--


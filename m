Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7507ECA2D
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 19:03:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3KDb-00010s-1s; Wed, 15 Nov 2023 13:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3KDX-00010O-Ou
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 13:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3KDT-0005VM-Ez
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 13:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700071338;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BfLSanqFGe8zia0aR9Z709KJOfPhnOe+26jPy/qPE60=;
 b=b59lBo3eFqlCS1+Q9xkkxqWVvRJPS5Wpj8fqh2tWk2ou0U4JEFxdva3qts71v1Ctaovpaj
 9mBEYrMS9sZhs3bhDl/drj3EkEo+/Ca1LKH8jV+UZ5Rtb7EhgTR8MEliB9yJHuL617ZgiG
 kvCqWJjvSAio6EPXQcJTKCA4UK8tzNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-H5u2j1KCOuCNKUyckw_FjA-1; Wed, 15 Nov 2023 13:02:15 -0500
X-MC-Unique: H5u2j1KCOuCNKUyckw_FjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35B1B811E8F;
 Wed, 15 Nov 2023 18:02:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC44D2026D4C;
 Wed, 15 Nov 2023 18:02:08 +0000 (UTC)
Date: Wed, 15 Nov 2023 18:02:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v3 53/70] i386/tdx: setup a timer for the qio channel
Message-ID: <ZVUHntznDEyUZovQ@redhat.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-54-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115071519.2864957-54-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 15, 2023 at 02:15:02AM -0500, Xiaoyao Li wrote:
> From: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> To avoid no response from QGS server, setup a timer for the transaction.
> If timeout, make it an error and interrupt guest. Define the threshold of
> time to 30s at present, maybe change to other value if not appropriate.
> 
> Extract the common cleanup code to make it more clear.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v3:
>  - Use t->timer_armed to track if t->timer is initialized;
> ---
>  target/i386/kvm/tdx.c | 155 ++++++++++++++++++++++++------------------
>  1 file changed, 89 insertions(+), 66 deletions(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 54b38c031fb3..3b87c36c485e 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -1069,6 +1069,8 @@ struct tdx_get_quote_task {
>      struct tdx_get_quote_header hdr;
>      int event_notify_interrupt;
>      QIOChannelSocket *ioc;
> +    QEMUTimer timer;
> +    bool timer_armed;
>  };
>  
>  struct x86_msi {
> @@ -1151,13 +1153,49 @@ static void tdx_td_notify(struct tdx_get_quote_task *t)
>      }
>  }
>  
> +static void tdx_getquote_task_cleanup(struct tdx_get_quote_task *t, bool outlen_overflow)
> +{
> +    MachineState *ms;
> +    TdxGuest *tdx;
> +
> +    if (t->hdr.error_code != cpu_to_le64(TDX_VP_GET_QUOTE_SUCCESS) && !outlen_overflow) {
> +        t->hdr.out_len = cpu_to_le32(0);
> +    }
> +
> +    /* Publish the response contents before marking this request completed. */
> +    smp_wmb();
> +    if (address_space_write(
> +            &address_space_memory, t->gpa,
> +            MEMTXATTRS_UNSPECIFIED, &t->hdr, sizeof(t->hdr)) != MEMTX_OK) {
> +        error_report("TDX: failed to update GetQuote header.");
> +    }
> +    tdx_td_notify(t);
> +
> +    if (t->ioc->fd > 0) {
> +        qemu_set_fd_handler(t->ioc->fd, NULL, NULL, NULL);
> +    }
> +    qio_channel_close(QIO_CHANNEL(t->ioc), NULL);
> +    object_unref(OBJECT(t->ioc));
> +    if (t->timer_armed)
> +        timer_del(&t->timer);
> +    g_free(t->out_data);
> +    g_free(t);
> +
> +    /* Maintain the number of in-flight requests. */
> +    ms = MACHINE(qdev_get_machine());
> +    tdx = TDX_GUEST(ms->cgs);
> +    qemu_mutex_lock(&tdx->lock);
> +    tdx->quote_generation_num--;
> +    qemu_mutex_unlock(&tdx->lock);
> +}
> +
> +
>  static void tdx_get_quote_read(void *opaque)
>  {
>      struct tdx_get_quote_task *t = opaque;
>      ssize_t size = 0;
>      Error *err = NULL;
> -    MachineState *ms;
> -    TdxGuest *tdx;
> +    bool outlen_overflow = false;
>  
>      while (true) {
>          char *buf;
> @@ -1202,11 +1240,12 @@ static void tdx_get_quote_read(void *opaque)
>           * There is no specific error code defined for this case(E2BIG) at the
>           * moment.
>           * TODO: Once an error code for this case is defined in GHCI spec ,
> -         * update the error code.
> +         * update the error code and the tdx_getquote_task_cleanup() argument.
>           */
>          t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_ERROR);
>          t->hdr.out_len = cpu_to_le32(t->out_len);
> -        goto error_hdr;
> +        outlen_overflow = true;
> +        goto error;
>      }
>  
>      if (address_space_write(
> @@ -1222,94 +1261,77 @@ static void tdx_get_quote_read(void *opaque)
>      t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_SUCCESS);
>  
>  error:
> -    if (t->hdr.error_code != cpu_to_le64(TDX_VP_GET_QUOTE_SUCCESS)) {
> -        t->hdr.out_len = cpu_to_le32(0);
> -    }
> -error_hdr:
> -    if (address_space_write(
> -            &address_space_memory, t->gpa,
> -            MEMTXATTRS_UNSPECIFIED, &t->hdr, sizeof(t->hdr)) != MEMTX_OK) {
> -        error_report("TDX: failed to update GetQuote header.");
> -    }
> -    tdx_td_notify(t);
> +    tdx_getquote_task_cleanup(t, outlen_overflow);
> +}
> +
> +#define TRANSACTION_TIMEOUT 30000
> +
> +static void getquote_timer_expired(void *opaque)
> +{
> +    struct tdx_get_quote_task *t = opaque;
> +
> +    tdx_getquote_task_cleanup(t, false);
> +}
>  
> -    qemu_set_fd_handler(t->ioc->fd, NULL, NULL, NULL);
> -    qio_channel_close(QIO_CHANNEL(t->ioc), &err);
> -    object_unref(OBJECT(t->ioc));
> -    g_free(t->out_data);
> -    g_free(t);
> +static void tdx_transaction_start(struct tdx_get_quote_task *t)
> +{
> +    int64_t time;
>  
> -    /* Maintain the number of in-flight requests. */
> -    ms = MACHINE(qdev_get_machine());
> -    tdx = TDX_GUEST(ms->cgs);
> -    qemu_mutex_lock(&tdx->lock);
> -    tdx->quote_generation_num--;
> -    qemu_mutex_unlock(&tdx->lock);
> +    time = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    /*
> +     * Timeout callback and fd callback both run in main loop thread,
> +     * thus no need to worry about race condition.
> +     */
> +    qemu_set_fd_handler(t->ioc->fd, tdx_get_quote_read, NULL, t);
> +    timer_init_ms(&t->timer, QEMU_CLOCK_VIRTUAL, getquote_timer_expired, t);
> +    timer_mod(&t->timer, time + TRANSACTION_TIMEOUT);
> +    t->timer_armed = true;
>  }
>  
> -/*
> - * TODO: If QGS doesn't reply for long time, make it an error and interrupt
> - * guest.
> - */
>  static void tdx_handle_get_quote_connected(QIOTask *task, gpointer opaque)
>  {
>      struct tdx_get_quote_task *t = opaque;
>      Error *err = NULL;
>      char *in_data = NULL;
> -    MachineState *ms;
> -    TdxGuest *tdx;
> +    int ret = 0;
>  
>      t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_ERROR);
> -    if (qio_task_propagate_error(task, NULL)) {
> +    ret = qio_task_propagate_error(task, NULL);
> +    if (ret) {
>          t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_QGS_UNAVAILABLE);
> -        goto error;
> +        goto out;
>      }
>  
>      in_data = g_malloc(le32_to_cpu(t->hdr.in_len));
>      if (!in_data) {
> -        goto error;
> +        ret = -1;
> +        goto out;
>      }
>  
> -    if (address_space_read(&address_space_memory, t->gpa + sizeof(t->hdr),
> -                           MEMTXATTRS_UNSPECIFIED, in_data,
> -                           le32_to_cpu(t->hdr.in_len)) != MEMTX_OK) {
> -        goto error;
> +    ret = address_space_read(&address_space_memory, t->gpa + sizeof(t->hdr),
> +                             MEMTXATTRS_UNSPECIFIED, in_data,
> +                             le32_to_cpu(t->hdr.in_len));
> +    if (ret) {
> +        g_free(in_data);
> +        goto out;
>      }
>  
>      qio_channel_set_blocking(QIO_CHANNEL(t->ioc), false, NULL);
>  
> -    if (qio_channel_write_all(QIO_CHANNEL(t->ioc), in_data,
> -                              le32_to_cpu(t->hdr.in_len), &err) ||
> -        err) {
> +    ret = qio_channel_write_all(QIO_CHANNEL(t->ioc), in_data,
> +                              le32_to_cpu(t->hdr.in_len), &err);
> +    if (ret) {
>          t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_QGS_UNAVAILABLE);
> -        goto error;
> +        g_free(in_data);
> +        goto out;
>      }
>  
> -    g_free(in_data);

Most of the diff  in this method is just arbitrary style
changes. Just do it right the first time in your previous
patch so we don't have lots of style changes in this patch.

> -    qemu_set_fd_handler(t->ioc->fd, tdx_get_quote_read, NULL, t);
> -
> -    return;
> -error:
> -    t->hdr.out_len = cpu_to_le32(0);
> -
> -    if (address_space_write(
> -            &address_space_memory, t->gpa,
> -            MEMTXATTRS_UNSPECIFIED, &t->hdr, sizeof(t->hdr)) != MEMTX_OK) {
> -        error_report("TDX: failed to update GetQuote header.\n");
> +out:
> +    if (ret) {
> +        tdx_getquote_task_cleanup(t, false);
> +    } else {
> +        tdx_transaction_start(t);
>      }
> -    tdx_td_notify(t);
> -
> -    qio_channel_close(QIO_CHANNEL(t->ioc), &err);
> -    object_unref(OBJECT(t->ioc));
> -    g_free(t);
> -    g_free(in_data);
> -
> -    /* Maintain the number of in-flight requests. */
> -    ms = MACHINE(qdev_get_machine());
> -    tdx = TDX_GUEST(ms->cgs);
> -    qemu_mutex_lock(&tdx->lock);
> -    tdx->quote_generation_num--;
> -    qemu_mutex_unlock(&tdx->lock);
>      return;
>  }
>  
> @@ -1382,6 +1404,7 @@ static void tdx_handle_get_quote(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
>      t->out_len = 0;
>      t->hdr = hdr;
>      t->ioc = ioc;
> +    t->timer_armed = false;
>  
>      qemu_mutex_lock(&tdx->lock);
>      if (!tdx->quote_generation ||
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



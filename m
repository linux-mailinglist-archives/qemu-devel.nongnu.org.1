Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6224E7B694E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:45:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnem8-0002lS-5L; Tue, 03 Oct 2023 08:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnem2-0002kp-5z
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnelw-0003AE-AR
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696337107;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1FxlBirWaqtOQc57OFySFosviOkv/DM29WIki3vxtWo=;
 b=EHN8guGgXKgj2Ja4LT9Fq6CZytFxuiZf0SjEInkNqWu1qVUWAeXcXmKb6ts4yM3xtG3NdE
 J1QN8f3vmvi9pSkkchk0WY10b5V0RH8ZRS7gUZxwlYhi8X8kBtSq0ZfxsmK6bAs8bjlAwf
 hI+B/JX+aRLZG7uPCAEbwA9LNqpVqa8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-yOzBWANpOumVx-D-sBlFlA-1; Tue, 03 Oct 2023 08:44:56 -0400
X-MC-Unique: yOzBWANpOumVx-D-sBlFlA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40554735995so6182815e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696337095; x=1696941895;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FxlBirWaqtOQc57OFySFosviOkv/DM29WIki3vxtWo=;
 b=msr/x7CGb6AdSac916a6hhiplzMDcRDiglwC5DjEOpXUFglyIeFpwjN6lrIX+7hzOv
 WiaFYMujnP120FZGEQCvckF5HTyafEfknXjJDwSdPGpP3mxNIlx7DujF2frdV2bYu4hF
 3kpX4D6hvcl/WDrc75CNgUq+Lrq59+ftTHbsifONJb+/8XeTLTFVjvRL7242TLmkBOVE
 qB4plgD4V2qHQxUtiZ3IrJgldQvcU06FguOpfMs/4uweYfEdLChUsdYkkYFCqusHBLWt
 udGdFpZow0vJ/Ga2/rcwd53YS/0iraXaD3KFrL5oe4HnculsfURZpaPAXQ/PRw+qcoGK
 317Q==
X-Gm-Message-State: AOJu0Yyp+0rvNjQSk47joTCQZgoWpfmAxC/LNNyyq1xtLrEAJYkhZuew
 TXcb1vWqEL1DPC6w5TMJH4bfZG8aHrbfwekia8JMYsXwt7ppTelZ67O2gtVIWxcLWVYvFEWgLyK
 GwD7+cRUm3kw94Yk=
X-Received: by 2002:a05:600c:3543:b0:406:52f1:7e6f with SMTP id
 i3-20020a05600c354300b0040652f17e6fmr12412020wmq.12.1696337094836; 
 Tue, 03 Oct 2023 05:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWVqKeHxbcRs2bIW1n6zbgwHnJGXCPSkhxQyooCO/OagDyLJwU9U2rb7dDaRSiqRQNwvk53g==
X-Received: by 2002:a05:600c:3543:b0:406:52f1:7e6f with SMTP id
 i3-20020a05600c354300b0040652f17e6fmr12412005wmq.12.1696337094502; 
 Tue, 03 Oct 2023 05:44:54 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z8-20020a7bc7c8000000b004053a6b8c41sm1230129wmk.12.2023.10.03.05.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:44:54 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com
Subject: Re: [PATCH v5 2/2] migration: Update error description outside
 migration.c
In-Reply-To: <20231003065538.244752-3-tejus.gk@nutanix.com> (Tejus GK's
 message of "Tue, 3 Oct 2023 06:55:38 +0000")
References: <20231003065538.244752-1-tejus.gk@nutanix.com>
 <20231003065538.244752-3-tejus.gk@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 03 Oct 2023 14:44:53 +0200
Message-ID: <874jj77u4a.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Tejus GK <tejus.gk@nutanix.com> wrote:
> A few code paths exist in the source code,where a migration is
> marked as failed via MIGRATION_STATUS_FAILED, but the failure happens
> outside	of migration.c
>
> In such	cases, an error_report() call is made, however the current
> MigrationState is never	updated	with the error description, and	hence
> clients	like libvirt never know	the actual reason for the failure.
>
> This patch covers such cases outside of	migration.c and	updates	the
> error description at the appropriate places.
>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Queued.

But I wonder.

> index 1f65294bf4..60eec7c31f 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -979,6 +979,8 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
>  static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
>  {
>      int ret;
> +    Error *local_err = NULL;
> +    MigrationState *s = migrate_get_current();
>  
>      if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
>          return 0;
> @@ -1002,6 +1004,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
>      } else {
>          ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc, &local_err);
>          if (ret) {
> +            migrate_set_error(s, local_err);
> +            error_report_err(local_err);

We are setting the error and reporting it.

>              return ret;
>          }
>      }
> @@ -1068,10 +1072,14 @@ void qemu_savevm_send_open_return_path(QEMUFile *f)
>  int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
>  {
>      uint32_t tmp;
> +    MigrationState *ms = migrate_get_current();
> +    Error *local_err = NULL;
>  
>      if (len > MAX_VM_CMD_PACKAGED_SIZE) {
> -        error_report("%s: Unreasonably large packaged state: %zu",
> +        error_setg(&local_err, "%s: Unreasonably large packaged state: %zu",
>                       __func__, len);
> +        migrate_set_error(ms, local_err);
> +        error_report_err(local_err);

Again we set the error and we report it.

>          return -1;
>      }
>  
> @@ -1499,8 +1507,11 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>           * bdrv_activate_all() on the other end won't fail. */
>          ret = bdrv_inactivate_all();
>          if (ret) {
> -            error_report("%s: bdrv_inactivate_all() failed (%d)",
> -                         __func__, ret);
> +            Error *local_err = NULL;
> +            error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
> +                       __func__, ret);
> +            migrate_set_error(ms, local_err);
> +            error_report_err(local_err);

Again.

>              qemu_file_set_error(f, ret);

And we still have qemu_file_set_error() here, ouch.

>              return ret;
>          }
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index dd9c76dbeb..4cde30bf2d 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -14,6 +14,7 @@
>  #include "migration.h"
>  #include "migration/vmstate.h"
>  #include "savevm.h"
> +#include "qapi/error.h"
>  #include "qapi/qmp/json-writer.h"
>  #include "qemu-file.h"
>  #include "qemu/bitops.h"
> @@ -336,7 +337,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>          ret = vmsd->pre_save(opaque);
>          trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>          if (ret) {
> -            error_report("pre-save failed: %s", vmsd->name);
> +            error_setg(errp, "pre-save failed: %s", vmsd->name);

Here we only set the error

>              return ret;
>          }
>      }
> @@ -389,8 +390,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                                       vmdesc_loop);
>                  }
>                  if (ret) {
> -                    error_report("Save of field %s/%s failed",
> -                                 vmsd->name, field->name);
> +                    error_setg(errp, "Save of field %s/%s failed",
> +                                vmsd->name, field->name);

Same here.

>                      if (vmsd->post_save) {
>                          vmsd->post_save(opaque);
>                      }


So, I am wondering if it could be better to just report the error in a
single place for migration, and set it whenever we need it?

That is independent of this patch, though.

Later, Juan.



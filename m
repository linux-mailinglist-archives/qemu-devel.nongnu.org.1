Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA97DCE39
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:51:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoEK-0007Y9-DB; Tue, 31 Oct 2023 08:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxoEG-0007WM-Qt
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxoEF-0003cZ-94
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698756738;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sM0IKxPgZ6sbV72HH+IDS+qMLVw/W6y60g+gIt1zLFQ=;
 b=jCBff9/iuDYMvuVqWpghMwGoSyyB3O9ynV9aYyStQQaaNpxtum0lMSJwAGGS9y2KwpgEFK
 ZcP+D94KtOQ3WgB/tq0kfIGAc4b9CCiMJHtY20VGW6LoovNcVYYzmVTABzEsRMCRL/RXgo
 QU0u5qCcV4AOOHJUuHRT8ClCe2Amurk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-aKljxSM7O8qLGe5vL1i2YA-1; Tue, 31 Oct 2023 08:52:12 -0400
X-MC-Unique: aKljxSM7O8qLGe5vL1i2YA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4083a670d25so40933945e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 05:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698756730; x=1699361530;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sM0IKxPgZ6sbV72HH+IDS+qMLVw/W6y60g+gIt1zLFQ=;
 b=jEumSqsCuvlN3oPKc+e1BDN0i+lGIxI5p05jL5sDpyA/MWCB7l1quPy4yekdJe3YQA
 EUlJM2LT1zVtwoVd7TyA7SH2DyD/9nXDsrTYARHcrnRYc5jejDDoWF1EyELE/xfaA1yL
 sEwXFBn2Wir05X9+PShkopmA00E3qyHQhJTjXRoPxBgz9u6ngU4Jkgo/lQKrfmCO1M6Z
 7qNZEkls3cvhn0LbgfINJoeFqANURR1AiDj86LcPJ6m6x09LEBvA3zIXDNp80lM6nOOY
 8aZdFgJe29vHXlfmpERdbhEY4YdXmD/jMlCWLw+LwtKTFjLIEzeoVYiuh9rtzgY4ue0l
 1eTA==
X-Gm-Message-State: AOJu0Yy6tn0P7p5KSWNLlst9BjKWRkoAQqqoq63TGGPf07nL72pcp8qo
 M4mm6Ow7RWTcj4t/rgquPIpUogpDocVJ1/D/PNBlizkbJkUTiJv7Cl6eMGzhVSwLdkcwkjlHvtx
 JxS80YaBSR2oLAb0=
X-Received: by 2002:a05:600c:4514:b0:409:101e:234d with SMTP id
 t20-20020a05600c451400b00409101e234dmr11325694wmo.12.1698756729909; 
 Tue, 31 Oct 2023 05:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUpJVjma7q9Nq4SSBiIcgL+U20FbJoK7WdUPO/C7uBwzlyCoN4YJEM1NFOWyauqx1WVzqdpg==
X-Received: by 2002:a05:600c:4514:b0:409:101e:234d with SMTP id
 t20-20020a05600c451400b00409101e234dmr11325669wmo.12.1698756729470; 
 Tue, 31 Oct 2023 05:52:09 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r8-20020a05600c35c800b004094c5d929asm1721936wmq.10.2023.10.31.05.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 05:52:08 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Joao Martins
 <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 3/5] migration: Add per vmstate downtime tracepoints
In-Reply-To: <20231030163346.765724-4-peterx@redhat.com> (Peter Xu's message
 of "Mon, 30 Oct 2023 12:33:44 -0400")
References: <20231030163346.765724-1-peterx@redhat.com>
 <20231030163346.765724-4-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 13:52:07 +0100
Message-ID: <87msvz7y4o.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> We have a bunch of savevm_section* tracepoints, they're good to analyze
> migration stream, but not always suitable if someone would like to analyze
> the migration downtime.  Two major problems:
>
>   - savevm_section* tracepoints are dumping all sections, we only care
>     about the sections that contribute to the downtime
>
>   - They don't have an identifier to show the type of sections, so no way
>     to filter downtime information either easily.
>
> We can add type into the tracepoints, but instead of doing so, this patch
> kept them untouched, instead of adding a bunch of downtime specific
> tracepoints, so one can enable "vmstate_downtime*" tracepoints and get a
> full picture of how the downtime is distributed across iterative and
> non-iterative vmstate save/load.
>
> Note that here both save() and load() need to be traced, because both of
> them may contribute to the downtime.  The contribution is not a simple "add
> them together", though: consider when the src is doing a save() of device1
> while the dest can be load()ing for device2, so they can happen
> concurrently.
>
> Tracking both sides make sense because device load() and save() can be
> imbalanced, one device can save() super fast, but load() super slow, vice
> versa.  We can't figure that out without tracing both.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.

>  static
>  int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>  {
> +    int64_t start_ts_each, end_ts_each;
>      SaveStateEntry *se;
>      int ret;
>  
> @@ -1475,6 +1476,8 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>                  continue;
>              }
>          }
> +
> +        start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
I still think that:
           int64_t start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);

>          trace_savevm_section_start(se->idstr, se->section_id);
>  
>          save_section_header(f, se, QEMU_VM_SECTION_END);
> @@ -1486,6 +1489,9 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>              qemu_file_set_error(f, ret);
>              return -1;
>          }
> +        end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);

and

           int64_t end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);

is clearer.

Having to pass the type thing is not "pleasant", but I can't think of a
better way to do it.

Later, Juan.



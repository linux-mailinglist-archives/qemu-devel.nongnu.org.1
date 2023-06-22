Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 565FA73A4C8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 17:26:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMAy-0003Dh-3d; Thu, 22 Jun 2023 11:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCMAv-0003DZ-W1
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCMAu-0001LB-CF
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687447482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ndOkFNNOvylVkfp0vlau9+OnvH7jmupKw+h1jgW82VA=;
 b=SJbUjEtJf0bxsSFm6V6w5Vw66DlvYgIsG7PGFnR8H+zBxRfMtD1++B/LilOLM+aEq1HAOV
 R5y/kgIZ2OBwMNHmuYiV+AEEKNCHdC8tW082Ydv+QtXNJFBK7XWuJ8zTfqbXJnEB0jKXpY
 TxyaUa6WYa//7J/VGekVAUYcs17ST/U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-CXISI1y9PLesvnpqHlM1qQ-1; Thu, 22 Jun 2023 11:24:28 -0400
X-MC-Unique: CXISI1y9PLesvnpqHlM1qQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3ff1fd64d57so11476851cf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 08:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687447460; x=1690039460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndOkFNNOvylVkfp0vlau9+OnvH7jmupKw+h1jgW82VA=;
 b=CYW9sJYyL6uJL3PowKqfRcQCqTg2/Gy1N9cTr+6fcDNQqKNnk+AUQM66HZOFFbcfyT
 2p8U/hM50aX+LkrN2uzYqkozXZtbn0YqchMCDcSRxKsP8hYuuNjYGV4W+k7i7YbZf3eQ
 Ykz4fEh1+kNOiuY2kaMYnJJMMuLcnYZ3FDYbkr+VvbvGCjwsQ6WlVFGjm9QWp8oao0kQ
 O0BZHZMhX26ssrWF8Qv258f5cu6j41UnFKtPmtBGK47Tw84xl0R5TVbm0iuv89Xg9KcR
 081z/vfEgW87rnQQvnHlKYT6okseMexVjmOBfI2xr0nPRVpTXoL5QRynf5Cmnqvim/L6
 VobA==
X-Gm-Message-State: AC+VfDzbnMjldU+1hxmW/FVGldn8cmGJ51tlX0TM/izERqXdk2kclJfX
 qHi1gMrY2xzelrTk4exRHOjdBv6xN9BNDfiscZW/6O4JacMP1za+2uXTUn1aLUid9B5yfPyF4hg
 j7iXvJEs8RBXBGCo=
X-Received: by 2002:a05:622a:1802:b0:3f9:a680:15 with SMTP id
 t2-20020a05622a180200b003f9a6800015mr24141029qtc.3.1687447460489; 
 Thu, 22 Jun 2023 08:24:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5S5SFXhQ/6JPqRThFRuitvhHv1voYnkg9NQUByDUZbli3Pu/4SeVrUjjg3vvxYPUIEnNIg7g==
X-Received: by 2002:a05:622a:1802:b0:3f9:a680:15 with SMTP id
 t2-20020a05622a180200b003f9a6800015mr24140997qtc.3.1687447460087; 
 Thu, 22 Jun 2023 08:24:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a7-20020ac84d87000000b003f6bbd7863csm3697677qtw.86.2023.06.22.08.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:24:19 -0700 (PDT)
Date: Thu, 22 Jun 2023 11:24:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Daniel =?utf-8?B?UC5CZXJyYW5nw6k=?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZJRnokKh47xe/4CE@x1n>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica>
 <59f958ac-807d-e940-e5de-8109de62eb8c@redhat.com>
 <87sfaj7r3g.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sfaj7r3g.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 22, 2023 at 12:01:55PM +0200, Juan Quintela wrote:
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 6/22/23 10:52, Juan Quintela wrote:
> >> User friendliness.
> >> The problem is that if you use more than two channels with multifd, on
> >> the incoming side, you need to do:
> >
> > You're sacrificing user-friendliness for the 99.99% that don't use
> > multifd, for an error (i.e. it's not even fixing the issue) for the
> > 0.01% that use multifd.  That's not user-friendly.
> 
> You are forgeting of the 0.01% that uses postocopy preempt (that is easy
> just changing the default value to 2), and the 0.0000001% that uses
> compression (they have exactly the same problem with compress_threads,
> compress_zlib, etc).
> 
> >> - migrate_set_parameter multifd-channels 16
> >> - migrate_incoming <uri>
> >> 
> >>> The issue is not how many features the command line has, but how
> >>> they're implemented.
> >> Or if they are confusing for the user?
> >
> > Anyone using multifd is not a typical user anyway.
> 
> >>> If they're just QMP wrappers and as such they're self-contained in
> >>> softmmu/vl.c, that's fine.
> >>>
> >>> In fact, even for parameters, we could use keyval to parse "-incoming"
> >> What is keyval?
> >
> > util/keyval.c and include/qemu/keyval.h.  It parses a list of
> > key=value pairs into a QDict.  Once you have removed the "source" key
> > from the QDict you can use a visitor to parse the rest into a
> > MigrateSetParameters.  See the handling of QEMU_OPTION_audio, it could
> > be something like
> >
> >
> >             case QEMU_OPTION_incoing: {
> >                 Visitor *v;
> >                 MigrateSetParameters *incoming_params = NULL;
> >                 QDict *dict = keyval_parse(optarg, "source", NULL,
> >                 &error_fatal);
> >
> >                 if (incoming) {
> >                     if (qdict_haskey(dict, "source")) {
> >                         error_setg(&error_fatal, "Parameter 'source'
> >                         is duplicate");
> >                     }
> >                 } else {
> >                     if (!qdict_haskey(dict, "source")) {
> >                         error_setg(&error_fatal, "Parameter 'source'
> >                         is missing");
> >                     }
> >                     runstate_set(RUN_STATE_INMIGRATE);
> >                     incoming = g_strdup(qdict_get_str(dict, "source"));
> >                     qdict_del(dict, "source");
> >                 }
> >
> >                 v = qobject_input_visitor_new_keyval(QOBJECT(dict));
> >                 qobject_unref(dict);
> >                 visit_type_MigrateSetParameters(v, NULL,
> >                 &incoming_params, &error_fatal);
> >                 visit_free(v);
> >                 qmp_migration_set_parameters(incoming_params,

PS: we may want to postpone this to be later than migration_object_init(),
when/if there's a real patch.

> >                 &error_fatal);
> >                 qapi_free_MigrateSetParameters(incoming_params);
> >             }
> >
> >
> > For example "-incoming [source=]tcp:foo,multifd-channels=16" would
> > desugar to
> >
> >   migrate_set_parameter multifd-channels 16
> >   migrate_incoming tcp:foo
> >
> > The only incompatibility is for people who are using "," in an URI,
> > which is rare and only an issue for the "exec" protocol.

If we worry on breaking anyone, we can apply the keyval parsing only when
!exec.  Not sure whether it matters a huge lot..

> 
> Aha, that makes sense.  And will allow us to deprecate/remove the
> --global migration.* stuff.

We may still need a way to set the caps/params for src qemu?..

Thanks,

-- 
Peter Xu



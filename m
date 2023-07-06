Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63813749E16
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:45:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPI1-00026b-Fk; Thu, 06 Jul 2023 09:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHPHw-00023H-CD
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHPHu-0007DY-82
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688651089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zj4ulP5Zhy8lzpQumKgb8yXloq2jyDGiqKaF67IeK5A=;
 b=CElnwmQpxMFFcIsY+HetJNBu+kKdeBhiKw4mZ0MGEYyZACkNOm7NAvoZLpyg9a6Rz9EQW+
 UhGDychS8uD71yQ2Mvi/qWK5rIb1xegpiVUa1xU3hJvpgnQ1suKQwXvQHmZ4m2jdjp9myg
 neKkZKkj4VQFgn9uK5xSnxguyLguYuM=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-tE_AwK7aPp2hASPgjouq7Q-1; Thu, 06 Jul 2023 09:44:48 -0400
X-MC-Unique: tE_AwK7aPp2hASPgjouq7Q-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-47e4d58e5ecso30930e0c.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688651087; x=1691243087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zj4ulP5Zhy8lzpQumKgb8yXloq2jyDGiqKaF67IeK5A=;
 b=Nym3dZv3A347UkR3HPxbbvF7be2EbLPJ4ykNbIg+g8cUgO9msYyd553xhZ101dOJXx
 cSnBuHLULkjCwyX5jpNPHb4Es6BC3mA0U0oh0ppq49UlrFZkg0tbLnGxBy+SJE0fi6py
 qHdYfNm4RldKoiYj52VHGre+Wj38PdlF4acdigTYPxg8W+ZQYGVu4DMkTI9Yu0mrK0Vr
 /1xehOz9NJNSkXHDIylTyn9FYwyT+m2ufPe50WEYE8a/JYmvFs3cE+du3a6e5F+V0Nl9
 j4b9Wt2gQ6/lCNOoUImbQzcAFs8QbLs4TBusa9c9kd+L5IWmMzhKwj1kQrdBO+36yU1L
 joLg==
X-Gm-Message-State: ABy/qLaoW/eq5UAnYET/Yxn3DvimiyC0T5J+qNewwa301QuT2cU9inxr
 y3UGgEj2At+dxGIyV7Q2vd0sxYLEk0UrQpvTnLTq4xpmqPOdLbpc912W6eQDqBX6DwvQwUUSsIH
 M6lYH6tMtyRYuZyo=
X-Received: by 2002:a1f:fc8a:0:b0:47b:847e:5899 with SMTP id
 a132-20020a1ffc8a000000b0047b847e5899mr1062776vki.1.1688651087644; 
 Thu, 06 Jul 2023 06:44:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0/l703+DZYjIZH/ORRZ2F23GXcLDNNtJxYkIxvKe5KrJv4uN2x+7MonXWd7K5PnTuzcgeDQ==
X-Received: by 2002:a1f:fc8a:0:b0:47b:847e:5899 with SMTP id
 a132-20020a1ffc8a000000b0047b847e5899mr1062760vki.1.1688651087346; 
 Thu, 06 Jul 2023 06:44:47 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b6-20020ac86786000000b003f9b9d7f319sm598210qtp.70.2023.07.06.06.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:44:47 -0700 (PDT)
Date: Thu, 6 Jul 2023 09:44:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 1/2] migration: switchover-hold parameter
Message-ID: <ZKbFTfqfXD53w84l@x1n>
References: <20230706124331.377939-1-peterx@redhat.com>
 <20230706124331.377939-2-peterx@redhat.com>
 <7bdfed14-0c32-901c-612c-3e66a79aa35e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bdfed14-0c32-901c-612c-3e66a79aa35e@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jul 06, 2023 at 04:29:22PM +0300, Avihai Horon wrote:
> > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> > index 9885d7c9f7..c3b3860f00 100644
> > --- a/migration/migration-hmp-cmds.c
> > +++ b/migration/migration-hmp-cmds.c
> > @@ -338,6 +338,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
> >           monitor_printf(mon, "%s: '%s'\n",
> >               MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> >               params->tls_authz);
> > +        monitor_printf(mon, "%s: %s\n",
> > +            MigrationParameter_str(MIGRATION_PARAMETER_SWITCHOVER_HOLD),
> > +            params->switchover_hold ? "on" : "off");
> > 
> >           if (params->has_block_bitmap_mapping) {
> >               const BitmapMigrationNodeAliasList *bmnal;
> > @@ -616,6 +619,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
> >           p->has_announce_step = true;
> >           visit_type_size(v, param, &p->announce_step, &err);
> >           break;
> > +    case MIGRATION_PARAMETER_SWITCHOVER_HOLD:
> > +        p->has_switchover_hold = true;
> > +        visit_type_bool(v, param, &p->switchover_hold, &err);
> 
> Should this sem post switchover_hold_sem like in the QMP case?

hmp_migrate_set_parameter() calls qmp_migrate_set_parameters() later, so
it'll be posted there.  Thanks,

-- 
Peter Xu



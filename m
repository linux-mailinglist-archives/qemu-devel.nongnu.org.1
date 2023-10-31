Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E658C7DD65E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:58:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtwV-0003HH-Ct; Tue, 31 Oct 2023 14:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxtwS-0003H9-Km
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxtwR-00060v-2V
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V33zMjHC8xhCmRE3xAdZ4kvY4xY0aNnvQh+wBFSVNnk=;
 b=Kfh1zoiz742A7RIXPADzuXRKmAg7SK2JIIvnIjJQ86kJ08oceclYck5/0FR2OVEAHOzOBi
 AR5rrPVyDD4t1kDCzqXRs9OahSsEsABxggCb2jpSEylGN7gW0Ml2ykgN07eNohgw2QrpHI
 UbwKa/E3LoLiMYns/HvrTEP0P835hc8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-8fsKfPhGMF2UvyhYw9R3Sg-1; Tue, 31 Oct 2023 14:58:05 -0400
X-MC-Unique: 8fsKfPhGMF2UvyhYw9R3Sg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77a029ff1a9so80911085a.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 11:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698778685; x=1699383485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V33zMjHC8xhCmRE3xAdZ4kvY4xY0aNnvQh+wBFSVNnk=;
 b=WYsKuIPEjS0EtHZNyUcBpjQNWym0w+U1n/yjfpfCDhRXu4KmFeRkeaxd4HA4vHBYM5
 /heKcsN/Vzf3TRSzIjG1MxnaLStlRkFWztMeqF6U6Sc88zziAxr8DrwehXK9u6EnkPvN
 NepjfM/OwhM/Je4VVckBhXlIQ7B3EcD1irdPXrRwG+tJEyFZoc1VAgdLCZvOJM8LEIKy
 Sq+yJyaKIpaM1gdobMi8k9Vf80e+GfdXL5Vrkvx61tikNFHigjP4TwF1bPmJXOpxPoUN
 V4ok1p1eW/2gvx9oMiyA6vUI6KgcTqwTzjgO1pBGK+W3AwwCuEJpq7JZD/H93wiAf3Yv
 fYkQ==
X-Gm-Message-State: AOJu0Yzz1+5OjBvyjFa7Ciz9vlOeWOeM5nC8MFjaJRIOUKDiiLW7UKYe
 2Liyg0AH5b6EVHy5T/8XcGKz7zaT2S94UrEj51MiXb1eB7cssygQpcaLWa+yeaQWxrUahlUdUmb
 6reXhfqbBE1vDx/w=
X-Received: by 2002:a05:620a:2725:b0:76c:ed4e:ac10 with SMTP id
 b37-20020a05620a272500b0076ced4eac10mr13324540qkp.6.1698778685363; 
 Tue, 31 Oct 2023 11:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrbH722U16mzia/CNxLc30+W+ig8kHwwe8mB6G2AJYrtL6WlqjswUtdDCBens1SM6YTLgjzQ==
X-Received: by 2002:a05:620a:2725:b0:76c:ed4e:ac10 with SMTP id
 b37-20020a05620a272500b0076ced4eac10mr13324522qkp.6.1698778685016; 
 Tue, 31 Oct 2023 11:58:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g4-20020a37e204000000b007789a3499casm741726qki.115.2023.10.31.11.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 11:58:04 -0700 (PDT)
Date: Tue, 31 Oct 2023 14:57:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 13/14] migration: Implement MigrateChannelList to hmp
 migration flow.
Message-ID: <ZUFONQcMUkW6QUgO@x1n>
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-14-farosas@suse.de>
 <87msvy4rjg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msvy4rjg.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Oct 31, 2023 at 06:42:43PM +0100, Juan Quintela wrote:
> Fabiano Rosas <farosas@suse.de> wrote:
> > From: Het Gala <het.gala@nutanix.com>
> >
> > Integrate MigrateChannelList with all transport backends
> > (socket, exec and rdma) for both src and dest migration
> > endpoints for hmp migration.
> >
> > Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> > Signed-off-by: Het Gala <het.gala@nutanix.com>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> 
> >      bool resume = qdict_get_try_bool(qdict, "resume", false);
> >      const char *uri = qdict_get_str(qdict, "uri");
> >      Error *err = NULL;
> > +    MigrationChannelList *caps = NULL;
> > +    g_autoptr(MigrationChannel) channel = NULL;
> >  
> > -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
> > +    if (!migrate_uri_parse(uri, &channel, &err)) {
> > +        goto end;
> > +    }
> > +    QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
> > +
> > +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
> >                   false, false, true, resume, &err);
> 
> 
> > -    if (hmp_handle_error(mon, err)) {
> > -        return;
> > -    }
> 
> I think that dropping this chunk is wrong.  What assures that
> qmp_migrate will not give an error?
> 
> > +    qapi_free_MigrationChannelList(caps);
> 
> 
> 
> 
> 
> >  
> >      if (!detach) {
> >          HMPMigrationStatus *status;
> > @@ -766,6 +780,9 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
> >                                            status);
> >          timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
> >      }
> > +
> > +end:
> > +    hmp_handle_error(mon, err);
> 
> 
> Oh, you put it here, but you enter in the detach case even if there is
> one error.
> 
> I think it is easier to just repeat the hmp_mhandle_error() inplace of
> the goto.

Agreed.  We don't want to kick the timer even if error..

-- 
Peter Xu



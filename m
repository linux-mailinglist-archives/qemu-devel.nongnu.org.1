Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C87C5506
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYnk-0003pV-7p; Wed, 11 Oct 2023 08:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqYnd-0003p8-MP
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqYnb-0006p3-RL
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697029130;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oUeXUhtx2ubv+/ix7w0bX1H5qOBfTVWLb2g4gpZOBHU=;
 b=CG66HH5A1e+YpJTpmKocDGkVYrTA7kaeb+eRUy5ip0YlspllWBFD1N8GqO7KkSBA2U4Id0
 YpwDUQ0I8L1hNde+7I2WhZ1mXRWR5Q20zVoSytlzMeLVNTrAyDNwTaaDN3D3NefDSbNZKr
 Od1MkmyTK8uNuhGXhC3jDyvfDkCAwKI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-IwLzF-rgN02Y9DhZhWbDHw-1; Wed, 11 Oct 2023 08:58:46 -0400
X-MC-Unique: IwLzF-rgN02Y9DhZhWbDHw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-502fff967ccso6058184e87.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 05:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697029125; x=1697633925;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUeXUhtx2ubv+/ix7w0bX1H5qOBfTVWLb2g4gpZOBHU=;
 b=MHz1+cA7oGDFt4PY0KHa4PJABkT84iOEbnD1b4MqJqtpDUFDgG9NOU+Rymv5k+E1o5
 0QxG0Aj/l+LXp+6cLfDTmhDl5XAACZxZpB/Hcj1X/m9dAWaOAshQb+uOEcApR4tMECqy
 +G0BhH8dsHduOxIxfPdsrcfGkgTPWXjsp3w9ThIM7dFkPpiXNUbVDt75nETjcuA/y+Vd
 pmjsTIV7R0u/ddYEyBhL8EgQcVt7rstdGUKZG52MsVhB/72YJkeNrbHTxsEvG+xP689q
 T/0MZz3IXqrYAMqJ6Qffo6YyzAzxjCtU96XkxtJUtUqZQJYw+HLXwpdjXV4y0tCsETDh
 B7vw==
X-Gm-Message-State: AOJu0YxNCEnVat/MFFJZnS8lVxwsa4axAJc1r6QunfSVNo3bAjE6qgFD
 sf57CWe6A2zfcfpAr7zCPFHdjCEGu0qvQfAVf3c50Bh8tt1fk2WIFAB6tsr+kytYn9WN/GILK02
 iWUqU/O02fvtTzgs=
X-Received: by 2002:a05:6512:1246:b0:500:9839:b13a with SMTP id
 fb6-20020a056512124600b005009839b13amr22736139lfb.66.1697029125171; 
 Wed, 11 Oct 2023 05:58:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdeMWRR4RwC0gDe1/6RmxUHeLfzIsKAsaTX6DR6e9X47YjcQaIaq4CqFVz6OejAaHvmfXh/w==
X-Received: by 2002:a05:6512:1246:b0:500:9839:b13a with SMTP id
 fb6-20020a056512124600b005009839b13amr22736112lfb.66.1697029124782; 
 Wed, 11 Oct 2023 05:58:44 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 u10-20020ac248aa000000b005041a71237asm2248184lfg.111.2023.10.11.05.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 05:58:44 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Chensheng Dong
 <chdong@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Zhiyi Guo
 <zhguo@redhat.com>,  Eric Blake <eblake@redhat.com>,  Joao Martins
 <joao.m.martins@oracle.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v4] migration: Allow user to specify available
 switchover bandwidth
In-Reply-To: <20231010221922.40638-1-peterx@redhat.com> (Peter Xu's message of
 "Tue, 10 Oct 2023 18:19:22 -0400")
References: <20231010221922.40638-1-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 14:58:42 +0200
Message-ID: <87mswpb9j1.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> Migration bandwidth is a very important value to live migration.  It's
> because it's one of the major factors that we'll make decision on when to
> switchover to destination in a precopy process.
>
> This value is currently estimated by QEMU during the whole live migration
> process by monitoring how fast we were sending the data.  This can be the
> most accurate bandwidth if in the ideal world, where we're always feeding
> unlimited data to the migration channel, and then it'll be limited to the
> bandwidth that is available.
>
> However in reality it may be very different, e.g., over a 10Gbps network we
> can see query-migrate showing migration bandwidth of only a few tens of
> MB/s just because there are plenty of other things the migration thread
> might be doing.  For example, the migration thread can be busy scanning
> zero pages, or it can be fetching dirty bitmap from other external dirty
> sources (like vhost or KVM).  It means we may not be pushing data as much
> as possible to migration channel, so the bandwidth estimated from "how many
> data we sent in the channel" can be dramatically inaccurate sometimes.
>
> With that, the decision to switchover will be affected, by assuming that we
> may not be able to switchover at all with such a low bandwidth, but in
> reality we can.
>
> The migration may not even converge at all with the downtime specified,
> with that wrong estimation of bandwidth, keeping iterations forever with a
> low estimation of bandwidth.
>
> The issue is QEMU itself may not be able to avoid those uncertainties on
> measuing the real "available migration bandwidth".  At least not something
> I can think of so far.
>
> One way to fix this is when the user is fully aware of the available
> bandwidth, then we can allow the user to help providing an accurate value.
>
> For example, if the user has a dedicated channel of 10Gbps for migration
> for this specific VM, the user can specify this bandwidth so QEMU can
> always do the calculation based on this fact, trusting the user as long as
> specified.  It may not be the exact bandwidth when switching over (in which
> case qemu will push migration data as fast as possible), but much better
> than QEMU trying to wildly guess, especially when very wrong.
>
> A new parameter "avail-switchover-bandwidth" is introduced just for this.
> So when the user specified this parameter, instead of trusting the
> estimated value from QEMU itself (based on the QEMUFile send speed), it
> trusts the user more by using this value to decide when to switchover,
> assuming that we'll have such bandwidth available then.
>
> Note that specifying this value will not throttle the bandwidth for
> switchover yet, so QEMU will always use the full bandwidth possible for
> sending switchover data, assuming that should always be the most important
> way to use the network at that time.
>
> This can resolve issues like "unconvergence migration" which is caused by
> hilarious low "migration bandwidth" detected for whatever reason.
>
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

> diff --git a/migration/options.h b/migration/options.h
> index 045e2a41a2..93ee938ab8 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -80,6 +80,7 @@ int migrate_decompress_threads(void);
>  uint64_t migrate_downtime_limit(void);
>  uint8_t migrate_max_cpu_throttle(void);
>  uint64_t migrate_max_bandwidth(void);
> +uint64_t migrate_avail_switchover_bandwidth(void);
>  uint64_t migrate_max_postcopy_bandwidth(void);
>  int migrate_multifd_channels(void);
>  MultiFDCompression migrate_multifd_compression(void);

This list of functions is alphabetically sorted, doing that during merge.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B65197D5917
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:47:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKXY-0005xR-Vi; Tue, 24 Oct 2023 12:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvKXT-0005wt-ED
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvKXR-0007pv-SU
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698165952;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ltZRN5BCq4lGfl5kGjKgl2Hwel6tskslokK6szXhLvA=;
 b=UJKAPs9z5PR8MHCUX+Goz5aSq7NwjtyFeRxWwLVhS+7FLVq5KAm4CcGMoB7aRO9j/fKA+Y
 4otDD9sxnzQsdX7FrhuS6pL6y/gbh1/0u2T9nvgkW2q/6H4YZ8ax1t1oVyJ/muVNbPNnl0
 GgCb296IBJJwpes0zIMF4byFnm+8fQU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-kdbVcNkRNIqNZCv_P7ZyWQ-1; Tue, 24 Oct 2023 12:45:47 -0400
X-MC-Unique: kdbVcNkRNIqNZCv_P7ZyWQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50798a259c7so4679837e87.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698165946; x=1698770746;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltZRN5BCq4lGfl5kGjKgl2Hwel6tskslokK6szXhLvA=;
 b=CAWQAK3ax2yms54Tf53m6+tQlsxqgVymyjFHfiZgJxzolHC5JQtach5E8/xlP7Aoa4
 dC/9/S1wNmEnhE45W1sXcAO+aj560vTSl/D6v9EnirQM+U0jYjUUgqTXvCjHY63vlGLC
 e5/J/TWq8XKLNzN4N+EjMJYBD8GlOowmrgnijAfO/L0V2mZShBuAIHytzdDb2XQsNswv
 WvoErtMK52PHh1PoRv5D/xx5ETBT6p+TKDyu9f8hSgRHrMRkjXgVUM04By4hbCbVDhjN
 z3AZ0R2QUIjScGX1zX9+NOhJ4BDLPXW5F2UqS8BSdAoKi6rJhx95LsPI5llgT1pW7vzI
 eTBA==
X-Gm-Message-State: AOJu0Yy0kEZZ97rDpYlHsfLpVCa7NBLyQRQqrLEwkHRyhL7Vy+EkMC56
 Jj+gASWuxHwpbZWB2m9N0H0sjiIxrL8+cWTRQyhzMlzvDSRO/UfnKoyhuap96gAvQX+h9XqMDZe
 RE3PmpiKGZ8izxSU=
X-Received: by 2002:a05:6512:2352:b0:507:a5dc:6d3e with SMTP id
 p18-20020a056512235200b00507a5dc6d3emr9678007lfu.31.1698165946543; 
 Tue, 24 Oct 2023 09:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiYOq74c8fA99jI6DuxvxQiBL0ZQr+nlE9jMAgwmG0wTFE5izaaKZgDLyGT3c0ZxsVAUbIEQ==
X-Received: by 2002:a05:6512:2352:b0:507:a5dc:6d3e with SMTP id
 p18-20020a056512235200b00507a5dc6d3emr9677996lfu.31.1698165946202; 
 Tue, 24 Oct 2023 09:45:46 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 h12-20020adff18c000000b0032d402f816csm10143988wro.98.2023.10.24.09.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:45:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhijian Li <lizhijian@fujitsu.com>,  Markus
 Armbruster <armbru@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH v3] migration: Stop migration immediately in RDMA error
 paths
In-Reply-To: <20231024163933.516546-1-peterx@redhat.com> (Peter Xu's message
 of "Tue, 24 Oct 2023 12:39:33 -0400")
References: <20231024163933.516546-1-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 18:45:45 +0200
Message-ID: <874jigklza.fsf@secure.mitica>
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
> In multiple places, RDMA errors are handled in a strange way, where it only
> sets qemu_file_set_error() but not stop the migration immediately.
>
> It's not obvious what will happen later if there is already an error.  Make
> all such failures stop migration immediately.
>
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF8D7DD490
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 18:22:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxsQo-0003wB-QL; Tue, 31 Oct 2023 13:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsQm-0003w3-NN
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsQl-0005Uv-6W
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698772890;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnqsYdF58eFi0Z0WqyisqXSRmQvtfwFafpFOaBscQo0=;
 b=QHk+0n0DHfsGVSk1h+dqSJ6LIspOxJYIHsgTfLLRcr7wveI+Xa8+DkHn+PZIGR1in4urtz
 wZdfX5SdeJZ0jn7xiqAGhkoFLuGGoVuLJQNCcz3DjMjfuk/ZkQK/0mZdnxLhfpz8BOo2CS
 PmbPQo6BuW7ghgiBFFkUxkZEVAghOpY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-NY_QrlPzNQS3cYutI7qwPQ-1; Tue, 31 Oct 2023 13:21:23 -0400
X-MC-Unique: NY_QrlPzNQS3cYutI7qwPQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32db6a28e24so2698225f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 10:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698772882; x=1699377682;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xnqsYdF58eFi0Z0WqyisqXSRmQvtfwFafpFOaBscQo0=;
 b=kv38vwGkw5ERwAiglRlNGH5p83zzuXQFuzfHCDsvHkN4iTZV+KPZYU/vWnlxLRdyry
 T7CLKiJb8UPkTVi/cXCbWzRWt8kxG53MaD9SRuhWyfW/jzdaGb+2Y/XTJX/YpYqd1/M0
 7SXzqgAWyAJizUHd40+x3TkC5SDmnepduNyfM/bmmbCaehZvklWz+Nj/qp46f+cHGUxy
 o1WhCutfThH0mNXO3ykCKJaPx6+SQXW9ysunSQPPvO71FSlinAH7y2+ozutRGKSY5kCE
 coFPFwf6WPFYMGdr0z1Lqnnuf+VvIoZ1iRuO9962CWLeqUatlOhghcFVu0GFCUdifFGG
 MWRA==
X-Gm-Message-State: AOJu0Ywi4k+oH+DfiY/LnUV94qj7T4aOTaSoBkdq2VZD5vnL6c0EpyDO
 GUybdMaHzFmLHs4ytzFgf0Hktsb/cKlLB1bAiHkBL8r1vdjMTvA7dR+Bc/sB5AW/YiZiqmNZU37
 eslb7M5K7gxonNkg=
X-Received: by 2002:a5d:4110:0:b0:32f:92b8:546c with SMTP id
 l16-20020a5d4110000000b0032f92b8546cmr2419190wrp.15.1698772882432; 
 Tue, 31 Oct 2023 10:21:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvPmYzCVOcM7g9tINChG4hcroRatLhwb45fjC2GrOW4htfoXG4i7nawLPd5lAv5NaD05qZLA==
X-Received: by 2002:a5d:4110:0:b0:32f:92b8:546c with SMTP id
 l16-20020a5d4110000000b0032f92b8546cmr2419178wrp.15.1698772882078; 
 Tue, 31 Oct 2023 10:21:22 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s26-20020adfa29a000000b003232380ffd5sm1926699wra.106.2023.10.31.10.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:21:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 11/14] migration: modify
 migration_channels_and_uri_compatible() for new QAPI syntax
In-Reply-To: <20231023182053.8711-12-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:50 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-12-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 18:21:20 +0100
Message-ID: <87y1fi4sj3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Fabiano Rosas <farosas@suse.de> wrote:
> From: Het Gala <het.gala@nutanix.com>
>
> migration_channels_and_uri_compatible() check for transport mechanism
> suitable for multifd migration gets executed when the caller calls old
> uri syntax. It needs it to be run when using the modern MigrateChannel
> QAPI syntax too.
>
> After URI -> 'MigrateChannel' :
> migration_channels_and_uri_compatible() ->
> migration_channels_and_transport_compatible() passes object as argument
> and check for valid transport mechanism.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>



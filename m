Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EF082D35F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:36:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDlE-0001fL-D0; Sun, 14 Jan 2024 22:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDlB-0001fA-UJ
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:35:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDlA-00078g-Fl
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705289735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICi8dkAm4wHBq3OGLaqwXhp6L3mOuNxERkpvi9kPcN0=;
 b=Gp8gmf+yHBBzkgDDQ96+YObPtVdftFaY86uj9gRBwUjmOCKbaogTl8dczj7XpkX1LiF/Da
 LAZnkTpmy2qPN1IwaJPdRABU39Op9zXDTWj4HGbZJfkVTJicU+O0/+xFrvNRjkBYalSQQi
 s9LlC5HOOpyMLhZwtY82YXK1Rq/nZE0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-6Qs7p5VPN_KbuSNltH87JA-1; Sun, 14 Jan 2024 22:35:33 -0500
X-MC-Unique: 6Qs7p5VPN_KbuSNltH87JA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bb87fc010fso10565348b6e.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705289733; x=1705894533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICi8dkAm4wHBq3OGLaqwXhp6L3mOuNxERkpvi9kPcN0=;
 b=tD5Fq7F3MoeVOkn8rV04AoBtqRnVSQh3rxuS4tCiI7EafUjonZVTGd05pfZJ8BcQhI
 ll3yL6aozor/QP7ndk2C/3yj0AjRiBxwn2nNYuFuaCjAf6d593cLAddTZvK5a3KaudcL
 qej103V/9GXlg8CmMZJVt9sruuW62G5OCe7JqXgpxQmMoWgLrUgy+f4/nMBG87NvqAyg
 QRa7w/DIU74NIUjWvLcH38lcALuc5oEfuqeupMdf4ufpKMbdiRJMlscIarSWjGofTNNG
 G7rDWLAHw9a+YHb3ajzggmRF1qZ2gepKzkcx6FAHlxkGXsa28d2MQDiyL4EJFsPn9pA2
 7q5Q==
X-Gm-Message-State: AOJu0YzKt4P+SmMKwTjlfOJgfuqdmYM91gONF/99IY7A1/GAuaEJTUwj
 Bh+OHTa2MfbJKPe83XKsCfuXJ+vUs4R0fE4Vv5gg6/VZsWzNBCwEO6EuOZu17ZWqdNU2Stl+P5Q
 faIUyvCr3v3fBfj7V7KAlgGV38pnH3+lriUlJGlE=
X-Received: by 2002:a05:6808:4091:b0:3bd:3b3b:15fe with SMTP id
 db17-20020a056808409100b003bd3b3b15femr4998793oib.119.1705289732843; 
 Sun, 14 Jan 2024 19:35:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGijsWjd+PfyMpAc496wj5l8xc9a7ifOY/NqBOufgm5sP95CeUa7c62951csjLGy0dFkLPJuCdqQuRxD7lquqo=
X-Received: by 2002:a05:6808:4091:b0:3bd:3b3b:15fe with SMTP id
 db17-20020a056808409100b003bd3b3b15femr4998786oib.119.1705289732701; Sun, 14
 Jan 2024 19:35:32 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-33-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-33-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:35:21 +0800
Message-ID: <CACGkMEsbPj-gzwL=Pw8skPc+8NGESHggFaUmMp2GxuV-a0tfsg@mail.gmail.com>
Subject: Re: [PATCH 32/40] vdpa: factor out vhost_vdpa_net_get_nc_vdpa
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Introduce new API. No functional change on existing API.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



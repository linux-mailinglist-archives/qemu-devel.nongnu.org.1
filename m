Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4D7D4DFC
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvElL-0001E1-S9; Tue, 24 Oct 2023 06:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvElK-0001C8-2b
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvElE-0006HH-Oj
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698143744;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQXXLSANRbpypIiYcOcBwPZPQwUAxgN3ZB8q/w4uDu0=;
 b=eN5hr0bonDoPKOBB2Emc6rnBnK59wyLx3r4BzOIAyuA4UranvRRJtKQYFmY+03FTMV0iF9
 0rMpZW8cdBHOXZF8FyrsmK1e+cMl5QwKAU9E1b9AxN0j+WJLtL+ngIP9mr7qBnvXbOurdf
 47P2N+cDMcIw8EPxBKhspuPIfjsONV4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-950GG6S3OLmW8zQ3N9wPew-1; Tue, 24 Oct 2023 06:35:32 -0400
X-MC-Unique: 950GG6S3OLmW8zQ3N9wPew-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso1762616f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698143731; x=1698748531;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KQXXLSANRbpypIiYcOcBwPZPQwUAxgN3ZB8q/w4uDu0=;
 b=YDM1xwiyHmiovwYMYALs98nx+J8sLQ/ptu4TJvFpOUadsjBrSKw0A+rRENR4BYzoNK
 pbYRxS9FWgFrUw76zttqpSo0rIevJNRd/JJ+RdLEKgu4/3Do5mu4CCkU9eNL5pukdOx1
 VdBD6KuAgaTRsf6hl3XoXrXKlkSDsMpfC3doQAAuzAOjlWKIjFbVnLb9Um72o4o6Qn8O
 R9LhH3H67/7w9+KTu5dTV8AqBygk3lxyfRFSVNuq0UGH5r67HXtI8TVKfNfwMxxSrtG1
 5r30ExEBXa/O25ACNYg3GBqapJrlAKVCBgkv5nV2QZ+biN58OHp89r03VlxHkZ9jR3OI
 EJbg==
X-Gm-Message-State: AOJu0Yy+G8xxInuYl9gh8ukgEck0T3PnjpurcS7/Ko5ZoSqNVai8c/5p
 8m8S7xJo/6QsNkSn/57e11CNvf7sJM+Ctq9J2vLx+LN1c3RwQTz9f8Jv7d1W4F3ArURUm82rC4A
 qr2Bx3Ji/fvff0bomNtyIt2A=
X-Received: by 2002:adf:e19e:0:b0:31f:d2dc:df26 with SMTP id
 az30-20020adfe19e000000b0031fd2dcdf26mr11524516wrb.28.1698143731350; 
 Tue, 24 Oct 2023 03:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5NFYIpjCHjsbXPtGsHOp4h/p+GsVJsR5a0zEEO2zi120FR6EvtgqYnmKZ2UR/SZb8iKqQ4Q==
X-Received: by 2002:adf:e19e:0:b0:31f:d2dc:df26 with SMTP id
 az30-20020adfe19e000000b0031fd2dcdf26mr11524500wrb.28.1698143731062; 
 Tue, 24 Oct 2023 03:35:31 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 q6-20020adfb186000000b0032326908972sm9741028wra.17.2023.10.24.03.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 03:35:30 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  John Snow
 <jsnow@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH v2 4/9] migration: rename
 vmstate_save_needed->vmstate_section_needed
In-Reply-To: <20231024084043.2926316-5-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Tue, 24 Oct 2023 12:40:38 +0400")
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
 <20231024084043.2926316-5-marcandre.lureau@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 12:35:30 +0200
Message-ID: <87a5s81f65.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The function is used on save at this point. The following commits will
> use it on load.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.



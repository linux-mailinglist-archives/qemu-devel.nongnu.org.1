Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06084A89D00
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 13:58:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4euy-0005K8-89; Tue, 15 Apr 2025 07:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u4euu-0005JN-P2
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u4euq-0003be-1p
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744718241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HqbU8lfYKhO1/tfA7qEO8oE2YfjL+R9vJPmao7tsgFE=;
 b=a7GnFvClyGHhIjzxMEs3mAkih8gXaHpU3R1djbsb/lfY5FTUVFhtPtHxNCwSr+en6CLKFp
 apCw0eQKI+/IT1VTHBOUD6oOiJF1DUXuxT5kbyOxM67V/dU4saukqPBGpuIzgDsP4JeqzV
 WJcnvnCDdWpXmUWVTG2sMq0ihjV+JdQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-9bFPCCqAN76XVFZ93L9D3w-1; Tue, 15 Apr 2025 07:57:20 -0400
X-MC-Unique: 9bFPCCqAN76XVFZ93L9D3w-1
X-Mimecast-MFC-AGG-ID: 9bFPCCqAN76XVFZ93L9D3w_1744718239
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ced8c2eb7so43592005e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 04:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744718239; x=1745323039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HqbU8lfYKhO1/tfA7qEO8oE2YfjL+R9vJPmao7tsgFE=;
 b=fq+VJNjeEJsizolzlfYH8Ei9DRB/G6qes4UVQ67jeGp/QxsS7G4K7hxI7YcBo2jGRk
 6HbffAa3f7FsOBAdr/ySvtgaaOsFY9N6iu9tLYEtMd+KchZvAoUqQ6u775AO+6dygzPR
 61WfwbKyLkWDI4re+TbUpy1XggYOT1DA2G5zudCFzKOwydewJDWoZwI7ezGMpSTZrfpt
 7Ynz8wjJ0nE+9ZPSiAk/tUjUqxcw0ksieB0F95pzKOgz3CEuhHJjMbYMHrF9qJHyC5Vs
 zCdWq0cnjzc9j5KBlXd5sxePycOKcE0N3xeUPlXz38iW8tSp0fPqMzBqzOXtfHecpLLo
 PXsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFVp3lasuDJqkGDbueT0vtOyGFbuC6ci4Wmta5yaakBlB1UvbqWKHKM+pOaWZqjws+w6JaJWtF6Cka@nongnu.org
X-Gm-Message-State: AOJu0Yw7yIiiiCXaDG/wT9s5pUnEDFhyRIFJyoHtPI2Bu5Kjb+NhIy4K
 5p48SC11BK+DB2Me5hfnkMzFU/+XyKrr8YiNEk9uas4ndQVRe115E56DrIPR9bzJ14+FAfpEi+p
 zHViwK9KQ9Nz4AZ7nXBoIQApszATLyl4xhltBYvSdmbXUYUNgtojx8AzTtwyUuKXs4btUr7kLZF
 IuJrQ6yHoJnl6k72SlbW9mtI2BKjw=
X-Gm-Gg: ASbGncvS7MkgV7z+5QAd92SWAxA8r64lrRBWEFhZegJTthsx7KyxFLF+o2v+HbEGzWB
 k3TYQ5VltHfxuBiZtQ4N6CDMB+CFZ/Ql9ANTkPMS8NTxaKZq8Bj3KQRw/0c0pTc/rvbOSSlk=
X-Received: by 2002:a05:600c:4fc1:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-43f3a9afc1emr115783425e9.25.1744718239253; 
 Tue, 15 Apr 2025 04:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq2SnvfrJ/+PIyzVxQFKWV+r3Na3bcXCEDlY/b7RT3oISZI0m/lGmMNK1mGuARFfuUEdLGxWZnE9iM9OG9QNY=
X-Received: by 2002:a05:600c:4fc1:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-43f3a9afc1emr115783315e9.25.1744718238937; Tue, 15 Apr 2025
 04:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
 <Z_4zL4y0UbmLJTsP@redhat.com>
 <CAE8KmOz-yGRXo2RiPpnhtcg2K+j38sK6C1eGHvpQf0L_Hfe3vw@mail.gmail.com>
 <Z_489fbXq-1Ihnhu@redhat.com>
In-Reply-To: <Z_489fbXq-1Ihnhu@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 15 Apr 2025 17:27:02 +0530
X-Gm-Features: ATxdqUG3udZq8y49oHX58oaq1DH8BbshYS3QbuLlNEXtCGmpaOFKeZQAag2AEMk
Message-ID: <CAE8KmOxMK_k6hUNm6XgLoRJOC5NO6V2owkqtK5KsmEeyc_kp2w@mail.gmail.com>
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Marco Cavenati <Marco.Cavenati@eurecom.fr>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 15 Apr 2025 at 16:33, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Because that's what the QEMU API specification declares
>  * Not all implementations will support this facility, so may report
>  * an error. To avoid errors, the caller may check for the feature
>  * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
>
> and what the QEMU API impl defines
>
>       if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_SEEKABLE)) {
>           error_setg_errno(errp, EINVAL, "Requested channel is not seekab=
le");
>           return -1;
>       }

* ie. _FEATURE_SEEKABLE should be set iff the underlying
channel/stream supports seek (random access) functionality, right?
That is quite connected with the lseek(2) OR ->io_seek() and such
support, no?

Thank you.
---
  - Prasad



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9017D4C2F
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 11:28:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDhT-0005Pf-3k; Tue, 24 Oct 2023 05:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvDhL-0005F2-6p
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvDhD-0006Bw-BD
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698139650;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIV5/5Xq0M3+qwJshypcO0jWQ8ULo9e/aLVFtpZFJmM=;
 b=JePKRY54n0NEsHTlkMcDVLhK4QRbr8BbfpCf3dTSHBL9RG+WlaJJ/Tbh8cZaI1rwf0aXpL
 lfcj9sSc5LULB0XXPMoZnUpfG7tGOD+AkJ8WKIrbo/aVB2LTBojZFL906ACbmIqzJsr8Ay
 qfTZsNJnqGT690uA7Yd3rm2IS61Ez2k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-4fO4lrF3MO6B4uxyd0Wk0w-1; Tue, 24 Oct 2023 05:27:23 -0400
X-MC-Unique: 4fO4lrF3MO6B4uxyd0Wk0w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-408534c3ec7so22718305e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 02:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698139642; x=1698744442;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fIV5/5Xq0M3+qwJshypcO0jWQ8ULo9e/aLVFtpZFJmM=;
 b=YjjlT9A4rAu07wYw/KW53GUo9pTk5I3b49dQt8CbcehvND5KsTEl7iF/yK21hvAs9P
 42GB3yCuFep9tKQEH2fZvHX3pPwD/NGA2oZt0FamJsiLlGnD7vZGLlYVj8+N0cZRawPa
 weWD4bhvxDNyDIZrySDri6GiwLOCCBu8/CDyM4v+iW2p0hUZLlz2tBqMQAyq5X+U05mr
 o/sQxnrnQOdhIB4hj8+WLZLzJJV/nDYCrAo2y2sea1Kuu7kaUZ/H/xV1MBitP0ZDejF+
 vdSSYG1W8bFLkWavqQDD+HmRRY1L+VKOV6O5e0nMNr7QOB5KzDq4XetWDIvefEjbhjmI
 BEHg==
X-Gm-Message-State: AOJu0YyOd3nJe96mbHXrIHcv+ReYem87sw6FPRZ+eXHosSyLjdZWwazU
 L3F8BA84xjFRTRsKVRzmWz0GkcKFV4PtpzK6Lijn1EK59ygHmpwcAx7CsqQ7TCB7TFTDOct7lpD
 a2WrsoFn8qXtAd8g=
X-Received: by 2002:a05:600c:4f0f:b0:408:3c9e:44b7 with SMTP id
 l15-20020a05600c4f0f00b004083c9e44b7mr8913807wmq.3.1698139642431; 
 Tue, 24 Oct 2023 02:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWWSFIxFFgbCKWlTD44YicmE0Ojc+66rlPIRv+cxKGb1FAwJmWPO+HA4FPQTxcsHo/WdK+LQ==
X-Received: by 2002:a05:600c:4f0f:b0:408:3c9e:44b7 with SMTP id
 l15-20020a05600c4f0f00b004083c9e44b7mr8913792wmq.3.1698139642155; 
 Tue, 24 Oct 2023 02:27:22 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m16-20020a7bca50000000b00405d9a950a2sm16037131wml.28.2023.10.24.02.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 02:27:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  John Snow
 <jsnow@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH v2 7/9] migration: set file error on subsection loading
In-Reply-To: <20231024084043.2926316-8-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Tue, 24 Oct 2023 12:40:41 +0400")
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
 <20231024084043.2926316-8-marcandre.lureau@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 11:27:20 +0200
Message-ID: <87msw81ibr.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> commit 13cde50889237 ("vmstate: Return error in case of error") sets
> QemuFile error to stop reading from it and report to the caller (checked
> by unit tests). We should do the same on subsection loading error.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.



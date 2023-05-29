Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34075714CA2
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eNh-00086j-2U; Mon, 29 May 2023 11:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q3eNf-00086Z-3s
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:01:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q3eNW-00086Z-87
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685372505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiVo+HLgtL+fIf2lzE8iFsDexvy102xLoEcawkWHDQQ=;
 b=i16qY4E2M7Q1hptxhohBBw83479aSMFEzHhhmyBrMo0RSwDRZbT2LI4ZCBnecLiivfsFR/
 s7aF11M5KuhsT8G/rkFCrzKVR8fs9xki9pSGT3u/h8dolzIhYF9rSSA33cChh6azvq9kUU
 ola/yIhzk7cdY9idza7aj1Js5BoSoVQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-oqV3drsMOuSgISZWQvS1yg-1; Mon, 29 May 2023 11:01:42 -0400
X-MC-Unique: oqV3drsMOuSgISZWQvS1yg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-623a54565e6so7441286d6.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 08:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685372502; x=1687964502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RiVo+HLgtL+fIf2lzE8iFsDexvy102xLoEcawkWHDQQ=;
 b=bepGzOBHV977rMBcvFL3mqdb7oCO3YlkD4eh6yhsegwp4g6n49T/973932/X3HO5SN
 Tn8jJ6Yju2+jvbLKPdgBAQibfDGxx6cF1f8lt4V3/kuV9ZgNRBccpzAhXQsYhIPpgM1j
 g8VMDSzxrhLtLEmnFebBM5ixI8xEZzKsUUFiH/7K7Lwix4V4pTd3WJAL8SLDlkqYyMns
 ES9MnvQ7jyLEwkua1hfDrJOvK0fWrHc5nn7Attihk5qIUXML+GysdaHSJRAVL9GZ9hd2
 Srs9Cqf+KFxQ3rkQbp6hqFl2EGgV61ogNveFoBzldzLjTrTOmxXEfLLdrdQK2GWN2hoT
 Y9aQ==
X-Gm-Message-State: AC+VfDw5pdX/JuhXM8l+GvHe8+bqwdHP9wOjnG8F4wSXUdITpKFPY+NO
 z5uHCIGzHEUJrluMv7z7EssF6sBxEwlQPreZHPgf1WKA2OX3c0x1cxSw0fHwOIjOlC2/PwgMWdJ
 wJgOm/buf+hnZaNFcaLL7tts=
X-Received: by 2002:a05:6214:1c48:b0:5ed:c96e:ca4a with SMTP id
 if8-20020a0562141c4800b005edc96eca4amr11731261qvb.1.1685372501760; 
 Mon, 29 May 2023 08:01:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ecwwpxiFNBGYclY0fVCI/VzBEY7uHVKnGrh6Vbo8IQ/1hmFo2AVYItg/y0uApl5WlXDkiAQ==
X-Received: by 2002:a05:6214:1c48:b0:5ed:c96e:ca4a with SMTP id
 if8-20020a0562141c4800b005edc96eca4amr11731236qvb.1.1685372501509; 
 Mon, 29 May 2023 08:01:41 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 s12-20020a05621412cc00b005fe4a301350sm3815020qvv.48.2023.05.29.08.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 08:01:40 -0700 (PDT)
Date: Mon, 29 May 2023 11:01:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 2/9] migration: Implement switchover ack logic
Message-ID: <ZHS+UkEHHV3JvDTP@x1n>
References: <20230528140652.8693-1-avihaih@nvidia.com>
 <20230528140652.8693-3-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230528140652.8693-3-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, May 28, 2023 at 05:06:45PM +0300, Avihai Horon wrote:
> Implement switchover ack logic. This prevents the source from stopping
> the VM and completing the migration until an ACK is received from the
> destination that it's OK to do so.
> 
> To achieve this, a new SaveVMHandlers handler switchover_ack_needed()
> and a new return path message MIG_RP_MSG_SWITCHOVER_ACK are added.
> 
> The switchover_ack_needed() handler is called during migration setup in
> the destination to check if switchover ack is used by the migrated
> device.
> 
> When switchover is approved by all migrated devices in the destination
> that support this capability, the MIG_RP_MSG_SWITCHOVER_ACK return path
> message is sent to the source to notify it that it's OK to do
> switchover.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



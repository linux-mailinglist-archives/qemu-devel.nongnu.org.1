Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D217B7FE8
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:55:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1PA-0007Ag-Jg; Wed, 04 Oct 2023 08:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qo1Oz-00076k-Ru
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qo1Ox-0000Of-C6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696424093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAoGcIm6E8LB8YPOEp93gThK5YTt14j1bOpE7XJoTBQ=;
 b=D9gvkyZtF1paOPwRNjky3/AwSEPxTaJaioiBP5uhCBzQKh9znzF7iOHmoAyD2rw2bBu5l+
 NsWBX/267xtvJtTlDsjHpm0kwmJm5vAOclAOr6BafUdqqFSdwCDogOJOzDvUIlboxYhxtJ
 HKpUuctBID/+jOrBfxEQ3p7kG3oLOCU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-G8pf38JaOn2hc0nCIxOayw-1; Wed, 04 Oct 2023 08:54:52 -0400
X-MC-Unique: G8pf38JaOn2hc0nCIxOayw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-323334992fbso1547188f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696424090; x=1697028890;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WAoGcIm6E8LB8YPOEp93gThK5YTt14j1bOpE7XJoTBQ=;
 b=raKQeQtSQ9UIqSIWcxywR/DZj/J1mW0DNZeLr1CXxyEYYASkemjllgLLAaQK7DMHyu
 tp3bbuNCLxYD+gH5Dvaccv86S5BHT8sE1iBywrMiv0qoOAPfJaOQONjBuF8Wn6kdbwox
 sHAnjPdwxbSLnamUet2QMfXf8fukWmDFC91h6eOmbni3UHEFmgzC1ks1hAGr5166QgSo
 xX1fcrCMDWx3V3siXGv4jc1F2acKbwPZjCfxyImgmsWxNNJT8jYoqnlpS3OfUjlFogZh
 rrxxcGvpHYxK+O2RozUfy2lzr30WEi7oZE1jyG4OLACAOLLebt19C+mBPENl4/emhSl+
 xuwQ==
X-Gm-Message-State: AOJu0Yx3P6NqyxJkw4+9mjKXIjowyAiQG/AcjUvWH8ewcpJNCxM3Imkv
 IrKJ8WQTJwBRvQndoyWAmsXCEpfmuLekCn7jR6qUdFqJFJa2cs8ywPh91DEEJfnSAJcBKUhsQuq
 Q983pnB8ACVGxaMVmjS3uG+0=
X-Received: by 2002:a05:6000:100e:b0:320:485:7010 with SMTP id
 a14-20020a056000100e00b0032004857010mr2160700wrx.67.1696424090649; 
 Wed, 04 Oct 2023 05:54:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkOVL4NoobTZEMBQjLB1RVFF1SjS9klOajeRwuXen7Ln6/YVhJw9QqQGK6vdmW2tS7BSKa3Q==
X-Received: by 2002:a05:6000:100e:b0:320:485:7010 with SMTP id
 a14-20020a056000100e00b0032004857010mr2160688wrx.67.1696424090342; 
 Wed, 04 Oct 2023 05:54:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:37ff:87f3:445a:631e:51a5])
 by smtp.gmail.com with ESMTPSA id
 p5-20020adfcc85000000b0031f300a4c26sm3933586wrj.93.2023.10.04.05.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 05:54:49 -0700 (PDT)
Date: Wed, 4 Oct 2023 08:54:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v3 1/7] vhost-user: strip superfluous whitespace
Message-ID: <20231004085350-mutt-send-email-mst@kernel.org>
References: <20231002203221.17241-1-lersek@redhat.com>
 <20231002203221.17241-2-lersek@redhat.com>
 <20231004050519-mutt-send-email-mst@kernel.org>
 <5f265558-71ae-7371-9fbb-dd0cfe1c69fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f265558-71ae-7371-9fbb-dd0cfe1c69fd@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Oct 04, 2023 at 12:08:52PM +0200, Laszlo Ersek wrote:
> On 10/4/23 11:06, Michael S. Tsirkin wrote:
> > On Mon, Oct 02, 2023 at 10:32:15PM +0200, Laszlo Ersek wrote:
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> > 
> > why the (supporter:vhost) part? not all scripts will cope
> > well with text after the mail. If you really want to keep
> > it around, I think you should add a hash tag # before that -
> > more tools know to ignore that.
> 
> It looked too tiresome to strip all these comments, plus I expected
> that, if the get_maintainer.pl script output these lines, they were fit
> for inclusion in "Cc:" tags in the commit message.
> 
> If they're not, then the tool should indeed insert a # in-between, or
> else provide the explanation for each name+email printed on separate
> (preceding) lines, potentially prefixed with "#". That makes for easy
> human reading and also for easy machine reading (filtering them out).
> 
> Laszlo

/me shrugs

get_maintainer.pl doesn't output Cc tags either. Just pipe to
sed 's/(.*//' ?

> > 
> > 
> >> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> >> Cc: German Maglione <gmaglione@redhat.com>
> >> Cc: Liu Jiang <gerry@linux.alibaba.com>
> >> Cc: Sergio Lopez Pascual <slp@redhat.com>
> >> Cc: Stefano Garzarella <sgarzare@redhat.com>
> >> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> >> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >> Tested-by: Albert Esteve <aesteve@redhat.com>
> >> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> >> ---
> >>
> >> Notes:
> >>     v3:
> >>     
> >>     - pick up R-b from Phil and Eugenio, T-b from Albert
> >>     
> >>     v2:
> >>     
> >>     - pick up Stefano's R-b
> >>
> >>  hw/virtio/vhost-user.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >> index 8dcf049d422b..b4b677c1ce66 100644
> >> --- a/hw/virtio/vhost-user.c
> >> +++ b/hw/virtio/vhost-user.c
> >> @@ -398,7 +398,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
> >>       * operations such as configuring device memory mappings or issuing device
> >>       * resets, which affect the whole device instead of individual VQs,
> >>       * vhost-user messages should only be sent once.
> >> -     * 
> >> +     *
> >>       * Devices with multiple vhost_devs are given an associated dev->vq_index
> >>       * so per_device requests are only sent if vq_index is 0.
> >>       */
> >>
> > 



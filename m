Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B838D9B052E
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 16:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L0v-00038S-CT; Fri, 25 Oct 2024 10:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t4L0s-000372-3f
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:10:02 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t4L0q-0007OE-Hy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:10:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729865357; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Cn1/Q2f3PZ1crfX/dvk3OQGeU8VUOkSkMfgk9yd5uwfryPEVFV0noFGrBDo/lghOk3jSS66dNl7gAPP82VqT6L6zdSNha3x53NDCiWFlaG/vGXse8wsw+o6ffRjZB+FhRtEOnuzCQLcUfvOwZp1lNh/9PzQy9Fpvo335oEpV7QM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729865357;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JH2KmVj6ZDTG8Y4XZLB5gufp5ngOeAqDbUE+ZX13wK0=; 
 b=lKkZKQftyCbE4BnlpQTTrk0g6BigoQpnaEk6rIDkyTAqjX3QYg687BzCcE2nMbrjDrxoMQ1LKC/ekKdrxxUGmWAVSRulRAwvxHgGv2LMRbInvTr/BlDd2YF1w0Fkeqfh/jFdicfRxXufLLyn2uqhwQO7sOWtmDS9dsAFdf7sN1I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729865357; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=JH2KmVj6ZDTG8Y4XZLB5gufp5ngOeAqDbUE+ZX13wK0=;
 b=fJOmC+wkdnXxWbiDxjwCWltkzIx2nwjz5S4YC0jdkXxVfwGLd0WJ6zRs5Wv9GuKD
 N2d9yKcUxIzIDwS058jaF6J13ybPXGa6qAItSvR00yJpq4+pjKZk+0oLXV4nsJZ+tlM
 WkaHVosgt6sGUhvIOH/STLUEWKwU0yq1VdncQCXk=
Received: by mx.zohomail.com with SMTPS id 1729865356164593.1557781912621;
 Fri, 25 Oct 2024 07:09:16 -0700 (PDT)
Message-ID: <fe40f7be-8e07-4f93-864f-13bf8aaacee8@collabora.com>
Date: Fri, 25 Oct 2024 17:09:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 00/13] Support blob memory and venus on qemu
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20241024210311.118220-1-dmitry.osipenko@collabora.com>
 <87ed44ilst.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87ed44ilst.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/25/24 12:17, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> Hello,
>>
>> This series enables Vulkan Venus context support on virtio-gpu.
>>
>> All virglrender and almost all Linux kernel prerequisite changes
>> needed by Venus are already in upstream. For kernel there is a pending
>> KVM patchset that fixes mapping of compound pages needed for DRM drivers
>> using TTM or huge pages [1], othewrwise hostmem blob mapping will fail
>> with a KVM error from Qemu.
> 
> While we wait for someone to volunteer to maintain for virtio-gpu I'm
> happy to get this series in for 9.2, hence:
> 
> Queued to maintainer/for-9.2, thanks.

Thanks a lot! :)

-- 
Best regards,
Dmitry


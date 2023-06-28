Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4CF740F21
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 12:46:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qESfP-0004X5-IW; Wed, 28 Jun 2023 06:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qESfN-0004Ws-9W
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qESfL-0005kS-C8
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687949087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=w6WgRwujZ9j3luaAsXaZbuUEEIvXa8kCHjT+PdqwAeQ=;
 b=NW4e4XRGQv/q8OumvuRJ6KFgIZB9YeDUhgMIQ+LpHVVCPcaN+piRYsMyrSDOgD+c65DxTB
 QsyhV+ApDbBk2C9OhjplNEXi1czaOmiIxq76dqyQEc1nqGCXqlrWmtsqrL60o9hRQ4/R3T
 jor5nFZUS0D78LTaaLoSFkGdw1n3Fp4=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-oJQQM6MgNbanFAhthI8iSg-1; Wed, 28 Jun 2023 06:44:46 -0400
X-MC-Unique: oJQQM6MgNbanFAhthI8iSg-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-43537754d86so551480137.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 03:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687949086; x=1690541086;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w6WgRwujZ9j3luaAsXaZbuUEEIvXa8kCHjT+PdqwAeQ=;
 b=EBEm6SkGxPVd9iPm6AK+d25ff3B5zJWAmM5W9D6jLMdYC+ogy3A0ziLJkyox0cSfwi
 UGZaZz8ubdOn4R0ky3KeIDrkXuGdEiC/a/gEqNMrkOoXnEYEUFlLdkaTGltOt0j4nLSK
 OAfLlwxtNHGbbNCEq8QoGNqK/inxawl1yVg8Bv7jXLuEvYpYAIPgGlvLIZVYO0ixVqnn
 IbkwopGefnURXbdhU17cGQgNzjtqji9RZm37DoOlLmtMOznhgWrPIO736QKoqFN3XNVj
 1q+VJsEhWq+APcyX0RYiXkbat8eNbTUxUrZ8kAYvVPNAoiehrTv0t7J323Srb01X9OMz
 j+4g==
X-Gm-Message-State: AC+VfDweE6IubLuor3PVfEkIW2tHxLIceD5EVrYxcfCoE9p2cLYPy+dI
 n75inGPS2Ful+f+SNQ3TQdQc0ffxsQxNoYFlJ4ws3bN+32AXd5UcKyVuNZN0W5aWqOtqYyzGNQF
 59BrwzxevyVeTsDMFHXUfyfqlBtbM6Mk=
X-Received: by 2002:a05:6102:3e29:b0:443:5524:8f8b with SMTP id
 j41-20020a0561023e2900b0044355248f8bmr290837vsv.4.1687949085802; 
 Wed, 28 Jun 2023 03:44:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6o7YkEq2oMRiPoz/1qX2TjFiX96yPRqJ75uigY+gfnwfRAUZll2KPiJq0oJxJEbeZ2vL28RTVVU4TlowbZXHQ=
X-Received: by 2002:a05:6102:3e29:b0:443:5524:8f8b with SMTP id
 j41-20020a0561023e2900b0044355248f8bmr290831vsv.4.1687949085555; Wed, 28 Jun
 2023 03:44:45 -0700 (PDT)
MIME-Version: 1.0
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 Jun 2023 12:44:33 +0200
Message-ID: <CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZN4sKDarSeu7DYoRbA@mail.gmail.com>
Subject: Azure infrastructure update
To: qemu@sfconservancy.org
Cc: qemu-devel <qemu-devel@nongnu.org>, Camilla Conte <cconte@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, "P. Berrange,
 Daniel" <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi all,

a small update on the infrastructure we have set up on Azure and the
expected costs. Remember that we have $10000/year credits from the
Microsoft open source program, therefore the actual cost to the
project is zero unless we exceed the threshold.

Historically, QEMU's infrastructure was hosted on virtual machines
sponsored by Rackspace's open source infrastructure program. When the
program was abruptly terminated, QEMU faced a cost of roughly
$1500/month, mostly due to bandwidth.

As an initial step to cut these costs, downloads were moved to Azure.
However, bandwidth costs remained high and in 2022 we exceeded the
credits from the sponsorship and we had to pay roughly $4000 to
Microsoft, in addition to roughly $2000 for VMs that were still hosted
on Rackspace. While not a definitive solution, this saved the project
an expense of over $10000.

Fortunately, the GNOME project stepped in and offered to host
downloads for QEMU on their CDN. This freed up all the Azure credits
for more interesting uses. In particular, Stefan and I moved the
Rackspace VMs over to Azure, after which the Rackspace bill went down
to zero.

This resulted in two VMs, both running CentOS Stream 9:
- a larger one (E2s instance type) for Patchew and wiki.qemu.org,
costing ~$1900/year between VMs and disks. The websites on this VM are
implemented as podman containers + a simple nginx front-end on ports
80/443.
- a smaller one (D2s instance type) one that proxies qemu.org and
git.qemu.org to gitlab and provides an SSH mirror of the QEMU
downloads, costing $1200/year between VMs and disks. This was a more
traditional monolithic setup.

We also have two virtual machines from OSUOSL (Oregon State University
Open Source Labs); one is unused and can be decommissioned; the other
(also running CentOS Stream 9) is running Patchew background jobs to
import patches and apply them.

Last April, Camilla Conte also added Kubernetes-based private runners
for QEMU CI to our Azure setup. Private runners avoid hitting the
GitLab limits on shared runners and shorten the time it takes to run
individual test jobs. This is because CI, thanks to its burst-y
nature, can use larger VMs than "pet" VMs such as the ones above.
Currently we are using 8 vCPU / 32 GB VMs for the Kubernetes nodes,
and each node is assigned 4 vCPUs.

Starting June 1, all pipelines running in qemu-project/qemu have been
using the private runners. Besides benefiting from the higher number
of vCPUs per job, this, it leaves the GitLab shared runner allowance
to Windows jobs as well as updates to qemu-web. It also made it
possible to estimate the cost of running Linux jobs on Azure at all
times, and to compare the costs with the credits that are made
available through the sponsorship.

Finally, earlier this month I noticed that the OSUOSL mirror for
download.qemu.org was not being updated. Therefore, I rebuilt the
qemu.org and git.qemu.org proxies as containers and moved them to the
same VM running Patchew, wiki.qemu.org and now the KVM Forum website
too. This made it possible to delete the second VM mentioned above. We
will re-evaluate how to provide the source for mirroring
download.qemu.org.

Our consumption of Azure credits was as follows:
* $2005 as of Jun 1, of which $371 used for the now-deleted D2s VM
* $2673 as of Jun 28, of which $457 used for the now-deleted D2s VM

Based on the credits consumed from Jun 1 to Jun 28, which should be
representative of normal resource use, I am estimating the Azure costs
as follows:

$6700 for this year, of which:
- $1650 for the E2s VM
- $450 for the now-deleted D2s VM
- $1600 for the Kubernetes compute nodes
- $2500 for AKS (Azure Kubernetes Service) including system nodes,
load balancing, monitoring and a few more itemized services(*)
- $500 for bandwidth and IP address allocation

$7800 starting next year, of which:
- $1900 for the E2s VM
- $2250 for the Kubernetes compute nodes
- $3100 for AKS-related services
- $550 for bandwidth and IP address allocation

This fits within the allowance of the Azure open source credits
program, while leaving some leeway in case of increased costs or
increased usage of the private runners. As a contingency plan in case
costs surge, we can always disable usage of the private runners and
revert to wider usage of shared runners.

That said, the cost for the compute nodes is not small. In particular,
at the last QEMU Summit we discussed the possibility of adopting a
merge request workflow for maintainer pull requests. These merge
requests would replace the pipelines that are run by committers as
part of merging trees, and therefore should not introduce excessive
costs. However, as things stand, in case of a more generalized
adoption of GitLab MRs(**) the QEMU project will *not* be able to
shoulder the cost of running our (pretty expensive) CI on private
runners for all merge requests.

Thanks,

Paolo

(*) not that we use any of this, but they are added automatically when
you set up AKS

(**) which was NOT considered at QEMU Summit



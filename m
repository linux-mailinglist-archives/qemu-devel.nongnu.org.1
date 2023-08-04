Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 357A17701B2
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 15:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRuva-0005kj-7b; Fri, 04 Aug 2023 09:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRuvH-0005jn-VA
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:32:59 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRuvD-0008HM-L8
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691155971; x=1722691971;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=SIKHAW6RQjNKcMdeVksZYEZlhu575Gr4F81H2N0ohvY=;
 b=eJfKDEcvDU72mpdPJ6YzM40uyE/5BWG0X8InEZgkff9zMvtWw7tyImM7
 pwlRKAkAr5D2gzP+72QSOwm+mu/cKyiW7bSyY7tsnybShqjv5r3l8A8Vi
 P07mOJWSMZk9aZiVlRU2yTVmVeTbDGuQ3tx5oUqjGvV5XvKqMMjuNIQZo
 QXC/JBiFql73XGc167fVhF0vzMvo12GGIf3lI8F2hDRNvJ6ICm3eQCvZr
 VuCkGoWCn6r+wD3LnQYaj3r2RJ9+gjOJ/5BzrOUtT2d9xfnnNCZ6/V7VV
 FUpOqACep4fnsMD95sHukHPlb119J57Q2FLtKRWJQ6bnnmmkZTfPs6AN1 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="370139375"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; d="scan'208";a="370139375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 06:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; d="scan'208";a="873390278"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2023 06:32:46 -0700
Date: Fri, 4 Aug 2023 21:43:11 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Like Xu <like.xu.linux@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 00/52] Introduce hybrid CPU topology
Message-ID: <ZM0Ab1sJJFhYJSP4@liuzhao-OptiPlex-7080>
References: <20230213095035.158240-1-zhao1.liu@linux.intel.com>
 <Y+o9VIV64mjXTcpF@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+o9VIV64mjXTcpF@redhat.com>
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Daniel and folks,

Let me pick up this thread again to discuss some updates from my work
on QOM CPU topology. I would like to know if I'm on the right track. :-)

On Mon, Feb 13, 2023 at 01:38:28PM +0000, Daniel P. Berrangé wrote:
>

[snip]

> 
> IIUC the functionality offered by -hybrid should be a superset
> of the -smp functionality. IOW, -smp ought to be possible to
> re-implement -smp as an alias for -hybrid, such that internally
> code only ever has to deal with the modern approach. Having to
> keep support for both -smp and -hybrid throughout the code is
> undesirable IMHO. Keeping the compat at the CLI parsing level
> limits the burden.
> 
> 
> As a more general thought, rather than introducing a new top level
> command line argument -hybrid, I'm thinking we should possibly just
> define this all using QOM and thus re-use the existing -object
> argument. 
> 
> I'm also finding the above example command lines quite difficult
> to understand, as there is alot of implicit linkage and expansion
> between the different levels. With devices we're much more
> explicitly with the parent/child relationships, and have to
> express everything with no automatic expansion, linking it all
> together via the id=/bus= properties.  This is quite a bit more
> verbose, but it is also very effective at letting us express
> arbitrarily complex relationships.
> 
> I think it would be worth exploring that approach for the CPU
> topology expression too.
> 
> If we followed the more explicit device approach to modelling
> then instead of:
> 
>  -cpu core,...
>  -cpu atom,...
>  -hybrid socket,sockets=1
>  -hybrid die,dies=1
>  -hybrid cluster,clusters=4
>  -hybrid core,cores=1,coretype="core",threads=2,clusterid=0-2
>  -hybrid core,cores=4,coretype="atom",threads=1
> 
> we would end up with something like
> 
>   -object cpu-socket,id=sock0
>   -object cpu-die,id=die0,parent=sock0
>   -object cpu-cluster,id=cluster0,parent=die0
>   -object cpu-cluster,id=cluster1,parent=die0
>   -object cpu-cluster,id=cluster2,parent=die0
>   -object cpu-cluster,id=cluster3,parent=die0
>   -object x86-cpu-model-atom,id=cpu0,parent=cluster0
>   -object x86-cpu-model-atom,id=cpu1,parent=cluster0
>   -object x86-cpu-model-atom,id=cpu2,parent=cluster0
>   -object x86-cpu-model-atom,id=cpu3,parent=cluster0
>   -object x86-cpu-model-core,id=cpu4,parent=cluster0,threads=2
>   -object x86-cpu-model-atom,id=cpu5,parent=cluster1
>   -object x86-cpu-model-atom,id=cpu6,parent=cluster1
>   -object x86-cpu-model-atom,id=cpu7,parent=cluster1
>   -object x86-cpu-model-atom,id=cpu8,parent=cluster1
>   -object x86-cpu-model-core,id=cpu9,parent=cluster1,threads=2
>   -object x86-cpu-model-atom,id=cpu10,parent=cluster2
>   -object x86-cpu-model-atom,id=cpu11,parent=cluster2
>   -object x86-cpu-model-atom,id=cpu12,parent=cluster2
>   -object x86-cpu-model-atom,id=cpu13,parent=cluster2
>   -object x86-cpu-model-core,id=cpu14,parent=cluster2,threads=2
>   -object x86-cpu-model-atom,id=cpu15,parent=cluster3
>   -object x86-cpu-model-atom,id=cpu16,parent=cluster3
>   -object x86-cpu-model-atom,id=cpu17,parent=cluster3
>   -object x86-cpu-model-atom,id=cpu18,parent=cluster3
>   -object x86-cpu-model-core,id=cpu19,parent=cluster3,threads=2
> 
> The really obvious downside is that it is much more verbose.

I find the "core" and "cluster" already have the abstraction as the
device, and Andreas also tried to abstract "socket" as the device.

So I find in this QOM way, all CPU topology levels should be
abstracted to devices and created via "-device". And I also need to
extend "cluster" device to support VM case as a general CPU topology
abstraction, not only just used in TCG emulation.

I've done a preliminary POC so far, where I can create the CPU topology
via "-device", and also added the ability to create the "child"
relationship in "-device" (since neither the "link" relationship nor
the bus looks like a good representation of the CPU hierarchy).

There's an example:

-device cpu-socket,id=sock0 \
-device cpu-die,id=die0,parent=sock0 \
-device cpu-die,id=die1,parent=sock0 \
-device cpu-cluster,id=cluster0,parent=die0 \
-device cpu-cluster,id=cluster1,parent=die0 \
-device cpu-cluster,id=cluster2,parent=die1 \
-device x86-intel-core,id=core0,parent=cluster0,threads=3 \
-device x86-intel-atom,id=core1,parent=cluster0,threads=2 \
-device x86-core,id=core2,parent=cluster1,threads=1 \
-device x86-intel-core,id=core3,parent=cluster2,threads=5 \

with the above format, I could build the the more accurate canonical
path for CPUs like this:

(QEMU) query-hotpluggable-cpus
{
    "arguments": {},
    "execute": "query-hotpluggable-cpus"
}
{
    "return": [
        {
            "props": {
                "cluster-id": 0,
                "core-id": 0,
                "die-id": 1,
                "socket-id": 0,
                "thread-id": 4
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die1/cluster2/core3/host-x86_64-cpu[10]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "cluster-id": 0,
                "core-id": 0,
                "die-id": 1,
                "socket-id": 0,
                "thread-id": 3
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die1/cluster2/core3/host-x86_64-cpu[9]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "cluster-id": 0,
                "core-id": 0,
                "die-id": 1,
                "socket-id": 0,
                "thread-id": 2
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die1/cluster2/core3/host-x86_64-cpu[8]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "cluster-id": 0,
                "core-id": 0,
                "die-id": 1,
                "socket-id": 0,
                "thread-id": 1
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die1/cluster2/core3/host-x86_64-cpu[7]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "cluster-id": 0,
                "core-id": 0,
                "die-id": 1,
                "socket-id": 0,
                "thread-id": 0
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die1/cluster2/core3/host-x86_64-cpu[6]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "cluster-id": 1,
                "core-id": 0,
                "die-id": 0,
                "socket-id": 0,
                "thread-id": 0
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die0/cluster1/core2/host-x86_64-cpu[5]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "cluster-id": 0,
                "core-id": 1,
                "die-id": 0,
                "socket-id": 0,
                "thread-id": 1
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die0/cluster0/core1/host-x86_64-cpu[4]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "cluster-id": 0,
                "core-id": 1,
                "die-id": 0,
                "socket-id": 0,
                "thread-id": 0
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die0/cluster0/core1/host-x86_64-cpu[3]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "cluster-id": 0,
                "core-id": 0,
                "die-id": 0,
                "socket-id": 0,
                "thread-id": 2
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die0/cluster0/core0/host-x86_64-cpu[2]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "cluster-id": 0,
                "core-id": 0,
                "die-id": 0,
                "socket-id": 0,
                "thread-id": 1
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die0/cluster0/core0/host-x86_64-cpu[1]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "cluster-id": 0,
                "core-id": 0,
                "die-id": 0,
                "socket-id": 0,
                "thread-id": 0
            },
            "qom-path": "/machine/peripheral/cpu-slot/sock0/die0/cluster0/core0/host-x86_64-cpu[0]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        }
    ]
}

Of course, I'm still a bit far from the full QOM topology support, but
would like to hear comments at the POC stage as well! :-)

Thanks and BR,
Zhao

> 
> This example only has 20 CPUs. For a VM with say 1000 CPUs
> this will be very big, but that doesn't neccesarily make it
> wrong.
> 
> On the flipside
> 
>  * It is really clear exactly how many CPUs I've added
> 
>  * The relationship between the topology levels is clear
> 
>  * Every CPU has a unique ID given that can be used in
>    later QMP commands
> 
>  * Whether or not 'threads' are permitted is now a property
>    of the specific CPU model implementation, not the global
>    config. IOW we can express that some CPU models allowing
>    for threads, and some don't.
> 
>  * The -cpu arg is also obsoleted, replaced by the
>    -object x86-cpu-model-core. This might facilitate the
>    modelling of machines with CPUs from different architectures.
> 
> 
> We could potentially compress the leaf node level by expressing
> how many instances of an object we want. it we want. ie, define
> a more convenient shorthand syntax to creating many instances of
> an object. so eg
> 
>   -object-set $TYPE,$PROPS,idbase=foo,count=4
> 
> would be functionally identical to
> 
>   -object $TYPE,$PROPS,id=foo.0
>   -object $TYPE,$PROPS,id=foo.1
>   -object $TYPE,$PROPS,id=foo.2
>   -object $TYPE,$PROPS,id=foo.3
> 
> QEMU just expands it and creates all the objects internally.
> 
> So the huge example I have above for 20 cpus would become much
> shorter: e.g.
> 
>   -object cpu-socket,id=sock0
>   -object cpu-die,id=die0,parent=sock0
>   -object cpu-cluster,id=cluster0,parent=die0
>   -object cpu-cluster,id=cluster1,parent=die0
>   -object cpu-cluster,id=cluster2,parent=die0
>   -object cpu-cluster,id=cluster3,parent=die0
>   -object-set x86-cpu-core-atom,idbase=cpu0,parent=cluster0,count=4
>   -object-set x86-cpu-core-core,id=cpu1,parent=cluster0,threads=2,count=1
>   -object-set x86-cpu-core-atom,idbase=cpu2,parent=cluster1,count=4
>   -object-set x86-cpu-core-core,id=cpu3,parent=cluster1,threads=2,count=1
>   -object-set x86-cpu-core-atom,idbase=cpu4,parent=cluster2,count=4
>   -object-set x86-cpu-core-core,id=cpu5,parent=cluster2,threads=2,count=1
>   -object-set x86-cpu-core-atom,idbase=cpu6,parent=cluster3,count=4
>   -object-set x86-cpu-core-core,id=cpu7,parent=cluster3,threads=2,count=1
> 
> IOW, the size of the CLI config only depends on the number of elements
> in the hierarchy, and is independant of the number of leaf CPU cores.
> 
> Obviously in describing all of the above, I've ignored any complexity
> of dealing with our existing code implementation and pain of getting
> it converted to the new model.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

